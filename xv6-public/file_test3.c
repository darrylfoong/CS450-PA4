#include "types.h"
#include "user.h"
#include "fcntl.h"

void
save(void)
{
    int fd;

    fd = open("small1", O_CREATE | O_SMALL | O_RDWR);
    if(fd >= 0) {
        printf(1, "ok: create small1 file succeed\n");
    } else {
        printf(1, "error: create small1 file failed\n");
        exit();
    }
   
    if(write(fd, "hello ", 6) != 6){
        printf(1, "error: write to small1 file failed\n");
        exit();
    }
    if(write(fd, "world", 5) != 5){
        printf(1, "error: write to small1 file failed\n");
        exit();
    }


    printf(1, "write ok\n");
    close(fd);
}

void
load(void)
{
    int fd;
    char dst[12];

    fd = open("small1", O_RDONLY);
    if(fd >= 0) {
        printf(1, "ok: read small1 file succeed\n");
    } else {
        printf(1, "error: read small1 file failed\n");
        exit();
    }
    if (read(fd, dst, 6) != 6) {
        printf(1, "error: read from small1 file failed\n");
        exit();
     }

    if(read(fd, dst + 6, 10) != 5) {
        printf(1, "error: read from small1 file failed\n");
        exit();
     }
    printf(1, "dst= %s\n", dst);

    printf(1, "read ok\n");
    close(fd);
}

int
main(void)
{
    save();
    load();

    exit();
}
