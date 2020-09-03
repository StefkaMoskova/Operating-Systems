//find argv[1] -type f -printf "%Ts %p\n" | sort -n | head -n 1 | cut -d " " -f2
#include <unistd.h>
#include <err.h>
#include <stdlib.h>

int main(int argc, char* argv[]){

    //number of pipes from the example above
    int fd1[2];
    int fd2[2];
    int fd3[2];
    
    if (argc != 2){
        errx(1, "Invalid number of arguments");
    }

    pipe(fd1);
    pipe(fd2);
    pipe(fd3);

    pid_t find_pid;
    pid_t sort_pid;
    pid_t head_pid;

    if((find_pid = fork()) == -1){
        errx(1, "error find fork");
    }

    if(find_pid == 0){
        close(fd1[0]);

        if(dup2(fd1[1],1) == -1){
            errx(1, "error dup2 find");
        }

        if(execlp("find", "find", argv[1], "-typef", "-printf", "%T@ %p\n", NULL) == -1){
            errx(1, "error execlp find");
        }
    }

    close(fd1[1]);

    if((sort_pid = fork()) == -1){
        errx(1, "error sort fork");
    }

    if(sort_pid == 0){
        close(fd2[0]);

        if(dup2(fd1[0],0) == -1){
            errx(1, "error dup2 sort");
        }

        if(dup2(fd2[1],1) == -1){
            errx(1, "error dup2 sort 2");
        }

        if(execlp("sort", "sort", "-n", NULL) == -1){
            errx(1, "error sort execlp");
        }
    }

    close(fd2[1]);

    if((head_pid = fork()) == -1){
        errx(1, "error head fork");
    }

    if(head_pid == 0){
        close(fd3[0]);

        if(dup2(fd2[0],0) == -1){
            errx(1, "error dup2 head");
        }

        if(dup2(fd3[1],1) == -1){
            errx(1, "error dup2 head 2");
        }

        if(execlp("head", "head", "-n1", NULL) == -1){
            errx(1, "error head execlp");
        }
    }

    close(fd3[1]);

    if(dup2(fd3[0],0) == -1){
            errx(1, "error dup2 cut");
    }
    
    execlp("cut", "cut", "-d", " ", "-f2", NULL);
    errx(1, "error cut fork");

    exit(0);
}
