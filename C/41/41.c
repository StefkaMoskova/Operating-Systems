#include <unistd.h>
#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <err.h>
#include <errno.h>

static off_t copyContent(int fdSrc, int fdDest){
	char buf[1<<9];
	off_t bytesCopied = 0;
	ssize_t rd;
	while((rd = read(fdSrc, &buf, sizeof(buf))) > 0){
		if(write(fdDest, &buf, rd) != rd)
			return -1;
		bytesCopied += rd;
	}
	return bytesCopied;
}

int main(int argc, char* argv[]){
    if (argc != 4){
        errx(1, "Invalid number of args");
    }

    int patch = open(argv[1], O_RDONLY); 
    int fd1 = open(argv[2], O_RDONLY); 

    int fd2 = open(argv[3], O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR); 
    
    if (patch == -1){
		errx(1, "Error opening file %s", argv[1]);
	}

    if (fd1 == -1){
		errx(1, "Error opening file %s", argv[2]);
	}

    if (fd2 == -1){
		errx(1, "Error opening file %s", argv[3]);
	}

    
    while (/* condition */)
    {
        /* code */
    }
    
    
    struct {
        uint16_t offset;
        uint8_t orgbyte;
        uint8_t newbyte;
    } __attribute__ ((packed)) element;

    if (read)
    {
        /* code */
    }
    

    close(fd1);
    close(fd2);
    close(patch);
    
    exit (0);
}

