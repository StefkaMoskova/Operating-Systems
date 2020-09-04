int main(int argc, char* argv[]){

    if (argc != 4)
    {
        errx(1, "Invalid number of arguments");
    }

    int fd1, fd2, fd3;
    fd1 = open(argv[1], O_RDONLY);
    fd2 = open(argv[2], O_RDONLY);
    fd3 = open(argv[3], O_RDWR | O_CREAT | O_TRUNC, S_IWUSR | S_IRUSR);

    if (fd1 == -1){ 
        errx(1, "Error while opnening fd1");
    }

    if (fd2 == -1){ 
        errx(1, "Error while opnening fd2");
    }

    if (fd3 == -1){ 
        errx(1, "Error while opnening fd3");
    }

    uint32_t x[2];
    uint32_t a;

    while (read(fd1, x, sizeof(x)) == sizeof(x))
    {
        off_t lpt = lseek(fd2,x[0]*sizeof(a),SEEK_SET);

        if (lpt == -1)
        {
            errx(1. "Error while lseek fd2");
        }
        
        for (uint32_t i = 0; i < x[1]; i++)
        {
            read(fd2, &a, sizeof(a));
            write(fd3, &a, sizeof(a));
        }
        
    }

    close(fd1);
    close(fd2);
    close(fd3);
    
    exit(0);
}