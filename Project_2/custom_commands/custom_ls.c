#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <fcntl.h>

#define COLOR_DIR   "\033[1;36m"   // Bold Cyan
#define COLOR_DEV   "\033[1;33m"   // Bold Yellow
#define COLOR_EXEC  "\033[1;32m"   // Bold Green
#define COLOR_RESET "\033[0m"      // Default text / reset

#define DIRSIZ 20 

int total_dirs = 0;
int total_files = 0;
int total_bytes = 0;

int flag_l = 0;
int flag_s = 0;

char* fmtname(char *path) {
    char *p;
    for(p = path + strlen(path); p >= path && *p != '/'; p--);
    p++;
    return p;
}

void print_file(char *path, struct stat *st, char *name) {
    char *color = COLOR_RESET;
    
    // Determine color based on standard POSIX macros & permissions
    if (S_ISDIR(st->st_mode)) {
        color = COLOR_DIR;
    } else if (S_ISCHR(st->st_mode) || S_ISBLK(st->st_mode)) {
        color = COLOR_DEV;
    } else if (S_ISREG(st->st_mode)) {
        // Checking the user-executable permission bit instead of file extension
        if (st->st_mode & S_IXUSR) {
            color = COLOR_EXEC; 
        }
    }
    
    if (flag_l) {
        printf("%s%s%s", color, name, COLOR_RESET);
        
        int len = strlen(name);
        for(int i = len; i < DIRSIZ; i++) {
            printf(" ");
        }
        
        char *type_str = (S_ISDIR(st->st_mode)) ? "DIR " : 
                         (S_ISCHR(st->st_mode) || S_ISBLK(st->st_mode)) ? "DEV " : "FILE";
                         
        printf(" %s ", type_str);
        printf("%lu %lld\n", (unsigned long)st->st_ino, (long long)st->st_size);
    } else {
        printf("%s%s%s  ", color, name, COLOR_RESET);
    }
}

void custom_ls(char *path) {
    char buf[1024]; 
    struct stat st;

    // Use lstat so we don't automatically follow symlinks
    if(lstat(path, &st) < 0) {
        fprintf(stderr, "custom_ls: cannot stat %s\n", path);
        return;
    }

    if (S_ISREG(st.st_mode) || S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
        if (S_ISREG(st.st_mode)) {
            total_files++;
            total_bytes += st.st_size;
        } else {
            total_files++; 
        }
        print_file(path, &st, fmtname(path));
        if (!flag_l) printf("\n");
        
    } else if (S_ISDIR(st.st_mode)) {
        DIR *dp = opendir(path);
        if (dp == NULL) {
            fprintf(stderr, "custom_ls: cannot open directory %s\n", path);
            return;
        }

        struct dirent *de;
        
        while((de = readdir(dp)) != NULL) {
            // IMPROVEMENT: Skip hidden files (files starting with '.')
            if (de->d_name[0] == '.') {
                continue;
            }
            
            if (snprintf(buf, sizeof(buf), "%s/%s", path, de->d_name) >= sizeof(buf)) {
                fprintf(stderr, "custom_ls: path too long\n");
                continue;
            }
            
            if(lstat(buf, &st) < 0) {
                fprintf(stderr, "custom_ls: cannot stat %s\n", buf);
                continue;
            }
            
            if (S_ISREG(st.st_mode) || S_ISCHR(st.st_mode) || S_ISBLK(st.st_mode)) {
                total_files++;
                if (S_ISREG(st.st_mode)) total_bytes += st.st_size;
            } else if (S_ISDIR(st.st_mode)) {
                total_dirs++;
            }
            
            print_file(buf, &st, de->d_name);
        }
        
        if (!flag_l) printf("\n");
        closedir(dp);
    }
}

int main(int argc, char *argv[]) {
    int paths_start = 1;
    
    for(int i = 1; i < argc; i++) {
        if(argv[i][0] == '-') {
            for(int j = 1; argv[i][j] != '\0'; j++) {
                if(argv[i][j] == 'l') flag_l = 1;
                else if(argv[i][j] == 's') flag_s = 1;
                else {
                    fprintf(stderr, "custom_ls: unknown flag -%c\n", argv[i][j]);
                    exit(1);
                }
            }
            paths_start++;
        } else {
            break;
        }
    }

    if(paths_start == argc) {
        custom_ls("."); 
    } else {
        for(int i = paths_start; i < argc; i++) {
            custom_ls(argv[i]);
            if (!flag_l && i < argc - 1) {
                printf("\n");
            }
        }
    }

    if (flag_s) {
        // Changed to standard bold magenta
        printf("\n\033[1;35m"); 
        printf("========================================\n");
        printf("           SUMMARY          \n");
        printf("========================================\n");
        printf("\033[0m"); 
        
        printf("  Total Directories : %d\n", total_dirs);
        printf("  Total Files       : %d\n", total_files);
        printf("  Total Bytes       : %d\n", total_bytes);
        
        printf("\033[1;35m"); 
        printf("========================================\n");
        printf("\033[0m"); 
    }

    exit(0);
}
