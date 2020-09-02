#include <unistd.h>
#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <err.h>
#include <errno.h>

static off_t statx(const char* fname){
    struct stat buff;

    if (stat(fname, &buff) == -1){
        errx(1, "Error stat fname");
    }

    if (!S_ISREG(buff.st_mode)){
        errx(1, "%s is not a regular file!", fname);
    }
    
    return buff.st_size;
}

static void readx(const int fd, uint8_t* const buff, const size_t sz, const char* const fname){
    size_t left = sz;
    while (left > 0) {
        const ssize_t n = read(fd, buff + sz - left, left);
        if (n == -1 ){
            errx(1, "Could not read from %s", fname);
        }
        
        else if (n == 0){
            errx(1, "Unexpected EOF on %s", fname);
        }
        
        left -= n;
    }
}

static void writex(const int fd, const uint8_t* const buff, const size_t sz, const char* const fname, const uint16_t offset){
    size_t left = sz;
    while (left > 0) {
        const ssize_t n = write(fd, buff + sz - left, left);
        if (n == -1 ){
            errx(1, "Could not write in %s", fname);
        }
        
        else if (n == 0){
            errx(1, "Unexpected write on %s", fname);
        }
        
        left -= n;
    }
}

int main(int argc, char* argv[]){
    if (argc != 4){
        errx(1, "Invalid number of args");
    }
    
    off_t fd1_size = statx(argv[1]);
    off_t fd2_size = statx(argv[2]);

    if (fd1_size != fd2_size){
        errx(1, "%s and %s have a diferent file size!", argv[1], argv[2]);
    }

    int fd1 = open(argv[1], O_RDONLY); 
    int fd2 = open(argv[2], O_RDONLY); 
    int patch = open(argv[3], O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR); 
    
    if (fd1 == -1){
		errx(1, "Error opening file %s", argv[1]);
	}

    if (fd2 == -1){
		errx(1, "Error opening file %s", argv[2]);
	}

    if (patch == -1){
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

