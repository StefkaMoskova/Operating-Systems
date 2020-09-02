#include <stdlib.h>
#include <err.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char* argv[]){
    int fd;
    fd = open(argv[1], O_RDWR);

    size_t buff_size = 4096; 
    uint8_t buff[buff_size];

    ssize_t read_size = 0;
    size_t stats[256] = {0};

    do
    {
        read_size = read(fd, &buff, sizeof(buff)); 
        if (read_size < 0)
        {
            int saved_errno = errno;
            close(fd);
            errno= saved_errno;
            errx(1, "Error while reading");
        }
        
        for (size_t i = 0; i < read_size; i++)
        {
            stats[buff[i]]++;
        }
        
    } while (read_size > 0);

    for (size_t i = 0; i < 256; i++)
    {
        uint8_t c = i;
        while (stats[i] > 0)
        {
            if (write(fd, &c, 1) != 1)
            {
                int saved_errno = errno;
                close(fd);
                errno=saved_errno;
                erxx(1, "Error while writing");
            }

            stats[i]--;  
        }    
    }

    close(fd);  
    exit(0);
}