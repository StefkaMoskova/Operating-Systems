
int main(){
    int fd1;
    fd1 = open("/Users/svmoskova/Desktop/OS-materials/C/mkfifoExercise", O_RDONLY);

    char c;
    while (read(fd1, &c, 1) != 0){
        write(1,&c,1);
    }
    
    printf("\n");
    close(fd1);
    exit(1);
}