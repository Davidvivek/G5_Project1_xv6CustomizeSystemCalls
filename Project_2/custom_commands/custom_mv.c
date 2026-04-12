#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

#ifndef O_BINARY
#define O_BINARY 0
#endif

// Process large files in standard 4KB chunks
#define BUFFER_SIZE   4096

// Acts like 'cp' + 'rm' if 'rename' fails (e.g., across separate hard drives)
int copy_and_delete(const char *source_path, const char *dest_path) {
    int source_fd, dest_fd;
    ssize_t bytes_read, bytes_written;
    char buffer[BUFFER_SIZE];

    // Start reading the original file
    source_fd = open(source_path, O_RDONLY | O_BINARY);
    if (source_fd < 0) {
        perror("custom_mv: Error opening source file");
        return 1;
    }

    // Create the destination file (or wipe it if it already exists)
    dest_fd = open(dest_path, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0644);
    if (dest_fd < 0) {
        perror("custom_mv: Couldn't open the destination file");
        close(source_fd);
        return 1;
    }

    // Copy the entire file chunk-by-chunk
    while ((bytes_read = read(source_fd, buffer, BUFFER_SIZE)) > 0) {
        bytes_written = write(dest_fd, buffer, bytes_read);
        if (bytes_written != bytes_read) {
            perror("custom_mv: Encountered an error while copying");
            close(source_fd);
            close(dest_fd);
            return 1;
        }
    }

    if (bytes_read < 0) {
        perror("custom_mv: Something went wrong reading the source file");
    }

    // Done copying! Turn off file access
    close(source_fd);
    close(dest_fd);

    // Delete the original file to fully complete the 'move' operation
    if (unlink(source_path) != 0) {
        perror("custom_mv: Copied successfully, but couldn't delete original file");
        return 1;
    }

    return 0;
}

int main(int argc, char *argv[]) {
    // Make sure we have our three arguments: custom_mv source dest
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <source_file> <destination_path>\n", argv[0]);
        return 1;
    }

    const char *source = argv[1];
    const char *dest = argv[2];

    // Try a standard rename first (fast metadata update on the same drive)
    if (rename(source, dest) == 0) {
        return 0;
    }

    // If rename failed (typically due to crossing filesystems), run our manual fallback
    fprintf(stderr, "custom_mv: Notice - Standard rename failed, falling back to copy+delete...\n");
    return copy_and_delete(source, dest);
}
