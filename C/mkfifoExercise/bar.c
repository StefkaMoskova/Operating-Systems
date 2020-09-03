int main(int argc, char* argv[]){
    char* temp = "/Users/svmoskova/Desktop/OS-materials/C/mkfifoExercise";
    mkfifo(temp, 0777);

    int fd1;
    fd1 = open(temp, O_WRONLY);

    int fd2;
    fd2 = open(argv[1], O_RDONLY);

    char c;
    while (read(fd2, &c, 1) != 0){
        write(fd1,&c,1);
    }

    close(fd1);
    close(fd2);
}