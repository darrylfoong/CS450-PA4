#include "types.h"
#include "user.h"
#include "fcntl.h"

void creating(void){
    int fd;
    fd = open("normalfile", O_CREATE | O_RDWR);

    if(fd >= 0) {
        printf(1, "Normal File Created Successfully\n");
    } else {
        printf(1, "Error: Normal File Failed to Create\n");
        exit();
    }
   
    if(write(fd, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus ullamcorper scelerisque. Sed non convallis quam. Fusce eleifend vulputate viverra. Sed dui tortor, finibus ut turpis eu, imperdiet feugiat nulla. Nunc at ullamcorper nunc. Vivamus eu iaculis ipsum. Quisque placerat enim vitae nisi mollis, eget ultricies massa convallis. Pellentesque ac tortor quis ante euismod dapibus malesuada a nisi. Donec malesuada nulla dui, in consectetur justo consequat ac. Integer nisl.", 487) != 487){
        printf(1, "error: write to ordinary file failed\n");
        exit();
    }

    printf(1, "Successfully Written to Normal File\n");
    close(fd);
}

void loading(void){
    int fd;
    char buf[512];
    fd = open("normalfile", O_RDONLY);

    if(fd >= 0) {
        printf(1, "Normal File Loaded Successfully\n");
    } else {
        printf(1, "Error: Normal File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 487) != 487) {
        printf(1, "Error: Failed to Read from Normal File\n");
        exit();
    }
    
    printf(1, "Contents: %s\n", buf);
    printf(1, "Normal File Successfully Loaded and Read\n");
    close(fd);
}

int
main(void)
{
    creating();
    loading();
    exit();
}
