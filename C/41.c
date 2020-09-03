#include <unistd.h>
#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <err.h>
#include <errno.h>

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
    
    struct {
        uint16_t offset;
        uint8_t orgbyte;
        uint8_t newbyte;
    } __attribute__ ((packed)) element;

    for (element.offset = 0; element.offset < fd1_size; element.offset += sizeof(element.orgbyte)){
        readx(fd1, &element.orgbyte,sizeof(element.orgbyte), argv[1]);
        readx(fd2, &element.newbyte,sizeof(element.newbyte), argv[2]);

        if (element.orgbyte != element.newbyte){
            writex(patch, (const uint8_t *)&element, sizeof(element), argv[3], element.offset);
        }
        
    }
    
    close(fd1);
    close(fd2);
    close(patch);
    
    exit (0);
}

