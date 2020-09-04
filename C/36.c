#include <stdint.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <err.h>

int main(){
    int fd1;
    int fd2;
    int fd3; 

    fd1 = open("f1", O_RDONLY);
    fd2 = open("f2", O_RDONLY);
    fd3 = open("f3", O_WRONLY|O_CREAT, S_IRUSR|S_IWUSR);

    if (fd1 == -1){
		errx(1, "Error opening file f1");
	}

    if (fd2 == -1){
		errx(1, "Error opening file f2");
	}

    if (fd3 == -1){
		errx(1, "Error opening file f3");
	}
    
    uint32_t x[2];
    uint32_t a;

    while (read(fd1, x, sizeof(x)) == sizeof(x)){
        off_t lpt = lseek(fd2, x[0]*sizeof(a),SEEK_SET);
        
        if (lpt == -1){
		errx(1, "Error lseek for file f1");
	    }

        for (uint32_t i = 0; i < x[1]; i++){
            read(fd2, &a, sizeof(a));
            write(fd3, &a, sizeof(a));
        }
        
    }

    close(fd1);
    close(fd2);
    close(fd3);
    
}