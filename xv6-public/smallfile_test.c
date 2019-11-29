#include "types.h"
#include "user.h"
#include "fcntl.h"

void creating(void){
    int fd;
    fd = open("smallfile", O_CREATE | O_SMALL | O_RDWR);

    if(fd >= 0) {
        printf(1, "Normal File Created Successfully\n");
    } else {
        printf(1, "Error: Normal File Failed to Create\n");
        exit();
    }
  
    if(write(fd, "Darryl ", 7) != 7){
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    if(write(fd, "and ", 4) != 4){
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    if(write(fd, "Mark", 4) != 4){
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    printf(1, "Successfully Written to Small File\n");
    close(fd);
}

void loading(void){
    int fd;
    char buf[16];
    fd = open("smallfile", O_RDONLY);

    if(fd >= 0) {
        printf(1, "Small File Loaded Successfully\n");
    } else {
        printf(1, "Error: Small File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 7) != 7) {
        printf(1, "Error: Failed to Read from Normal File\n");
        exit();
    }
    if (read(fd, buf+7, 4) != 4) {
        printf(1, "error: failed to read from normal file\n");
        exit();
    }
    if (read(fd, buf+11, 4) != 4) {
        printf(1, "error: failed to read from normal file\n");
        exit();
    }

    printf(1, "Contents: %s\n", buf);
    printf(1, "Small File Successfully Loaded and Read\n");
    close(fd);
}

int main(void){
    creating();
    loading();
    exit();
}
