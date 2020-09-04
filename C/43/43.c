#include <fcntl.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <unistd.h>
#include <err.h>
#include <sys/errno.h>

static off_t copyContent(int fdSrc, int fdDest){
	char buf[1<<9];
	off_t bytesCopied = 0;
	ssize_t rd;
	while((rd = read(fdSrc, &buf, sizeof(buf))) > 0){
		if(write(fdDest, &buf, rd) != rd)
			return -1;
		bytesCopied += rd;
	}
	return bytesCopied;
}

int main(int argc, char* argv[]){

    if (argc != 3)
    {
        errx(1, "Invalid number of arguments");
    }
    
    int input_fd, output_fd;
    input_fd = open(argv[1], O_RDONLY);
    output_fd = open(argv[2], O_RDWR | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
    
    copyContent(input_fd, output_fd);

    const size_t buff_size = 4096;
    uint32_t buff[buff_size];

    size_t read_size = 0;
    size_t stats[256] = {0};

    do
    {
        read_size = read(output_fd, &buff, sizeof(buff)); 
        if (read_size < 0)
        {
            int saved_errno = errno;
            close(output_fd);
            errno = saved_errno;
            errx(1, "Error while reading output file");
        }
        
        for (size_t i = 0; i < read_size; i++)
        {
            stats[buff[i]]++;
        }
        
    } while (read_size > 0);

    lseek(output_fd, 0, SEEK_SET);

    for (size_t i = 0; i < 256; i++)
    {
       uint32_t c = i;
		while (stats[i] > 0){
			if (write(output_fd,&c, 1) != 1){
				int saved_errno = errno;
				close(output_fd);
				errno = saved_errno;
				errx(1, "Error while writing");
			}
			stats[i]--;
		}
    }
    
    exit (0);
}
