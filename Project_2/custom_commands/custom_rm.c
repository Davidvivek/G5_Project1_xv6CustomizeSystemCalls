#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <errno.h>

int total_files_deleted = 0;
int total_dirs_deleted = 0;

int flag_r = 0; 
int flag_v = 0; 
int flag_s = 0; 

void custom_rm(char *path) {
    char buf[1024]; 
    struct stat st;

    // Use lstat to not follow symlinks (we want to delete the link, not the target)
    if(lstat(path, &st) < 0) {
        fprintf(stderr, "custom_rm: cannot stat '%s': %s\n", path, strerror(errno));
        return;
    }

    if (S_ISDIR(st.st_mode)) {
        if (!flag_r) {
            fprintf(stderr, "custom_rm: cannot remove '%s': Is a directory (use -r)\n", path);
            return;
        }

        DIR *dp = opendir(path);
        if (dp == NULL) {
            fprintf(stderr, "custom_rm: cannot open directory '%s': %s\n", path, strerror(errno));
            return;
        }

        struct dirent *de;
        
        while((de = readdir(dp)) != NULL) {
            // Skip current and parent directory pointers
            if (strcmp(de->d_name, ".") == 0 || strcmp(de->d_name, "..") == 0) {
                continue;
            }
            
            if (snprintf(buf, sizeof(buf), "%s/%s", path, de->d_name) >= sizeof(buf)) {
                fprintf(stderr, "custom_rm: path too long\n");
                continue;
            }
            
            // Recursively delete contents
            custom_rm(buf);
        }
        closedir(dp);

        // After contents are deleted, remove the directory itself
        if (rmdir(path) == 0) {
            total_dirs_deleted++;
            if (flag_v) {
                printf("removed directory: '%s'\n", path);
            }
        } else {
            fprintf(stderr, "custom_rm: cannot remove directory '%s': %s\n", path, strerror(errno));
        }

    } else {
        // It's a file, symlink, or device node; use unlink
        if (unlink(path) == 0) {
            total_files_deleted++;
            if (flag_v) {
                printf("removed file: '%s'\n", path);
            }
        } else {
            fprintf(stderr, "custom_rm: cannot remove '%s': %s\n", path, strerror(errno));
        }
    }
}

int main(int argc, char *argv[]) {
    int paths_start = 1;
    
    // Parse flags
    for(int i = 1; i < argc; i++) {
        if(argv[i][0] == '-') {
            for(int j = 1; argv[i][j] != '\0'; j++) {
                if(argv[i][j] == 'r' || argv[i][j] == 'R') flag_r = 1;
                else if(argv[i][j] == 'v') flag_v = 1;
                else if(argv[i][j] == 's') flag_s = 1;
                else {
                    fprintf(stderr, "custom_rm: unknown flag -%c\n", argv[i][j]);
                    exit(1);
                }
            }
            paths_start++;
        } else {
            break;
        }
    }

    if(paths_start == argc) {
        fprintf(stderr, "custom_rm: missing operand\n");
        fprintf(stderr, "Usage: custom_rm [-rvs] <file1> <file2> ...\n");
        exit(1);
    } else {
        // Prevent accidental deletion of current/root directories
        for(int i = paths_start; i < argc; i++) {
            if (strcmp(argv[i], "/") == 0 || strcmp(argv[i], ".") == 0 || strcmp(argv[i], "..") == 0) {
                fprintf(stderr, "custom_rm: refusing to remove '.' or '/' or '..'\n");
                continue;
            }
            custom_rm(argv[i]);
        }
    }

    if (flag_s) {
        printf("\n========================================\n");
        printf("            DELETION SUMMARY            \n");
        printf("========================================\n");
        printf("  Directories Removed : %d\n", total_dirs_deleted);
        printf("  Files Removed       : %d\n", total_files_deleted);
        printf("========================================\n");
    }

    return 0;
}
