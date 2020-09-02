#include <unistd.h>
#include <err.h>
#include <stdlib.h>

int main(int argc, char* argv[]){
    if (argc != 2)
    {
        errx(1, "Wrong number of arguments");
    }

    int fd[2];
    pipe(fd);
    pid_t cat_pid;

    if (cat_pid == fork() = -1)
    {
        errx(1, "Error cat fork");
    }
    
    if (cat_pid == 0)
    {
        close(fd[0]);

        if (dup2(fd[1],1) == -1)
        {
            errx(1, "Error cat dup2");
        }

        if (execlp("cat", "cat", argv[1], NULL) == -1)
        {
            errx(1, "Error cat execlp");
        }
    }

    close(fd[1]);

    if (dup2(fd[0], 0) == -1)
    {
        errx(1, "Error sort dup2");
    }

    if (execlp("sort", "sort", NULL) == -1)
    {
        errx(1, "Error sort execlp");
    }
    
    exit(0);
}