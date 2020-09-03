// Напишете програма на С, която да работи като обвивка на командата sort - тоест, вашата програма изпълнява sort, като всички параметри
// подадени на командния ред, да се предават на sort. Изхода за грешки по време на изпълнението да отива във файл с име serror.txt
#include <unistd.h>
#include <stdint.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <err.h>
#include <errno.h>

int main(){

    int fd1;
    fd1 = open("serror.txt", O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
    
    if(fd1 == -1)
    {
        err("Error opening file");
    }

    dup2(fd1, 2);

    if (execvp("sort", argv) == -1){
        err(1, "Error execvp sort");
    }
    
    exit(0);
}