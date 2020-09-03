#include <stdlib.h>
#include <err.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>


// size_t - instead of unsigned int
// ssize_t - instead of int
// Because strlen, string, vector... all use size_t, so I usually use size_t. And I only use ssize_t when it may be negative.

int main(int argc, char* argv[]) {
	if (argc != 2){
		errx(1, "Invalid number of arguments");
	}

	int fd; 
	fd = open(argv[1], O_RDWR);
	if (fd == -1){
		errx(1, "Error opening the file");
	}

	const size_t buf_size = 4096;
	uint8_t buf[buf_size];

	size_t read_size =0;
	size_t stats[256]={0};

	// To take the number of elements(file size) we use stats

	do {
		read_size = read (fd, &buf, sizeof(buf));
		if (read_size < 0){
			int saved_errno = errno;
			close(fd);
			errno = saved_errno;
			errx(1, "Error while reading");
		}
		
		for (size_t i = 0; i < read_size; i++){
			stats[buf[i]]++;
		}
		
	} while (read_size > 0);

	lseek(fd, 0, SEEK_SET);

	for (size_t i = 0; i < 256; i++){
		uint8_t c = i;
		while (stats[i] > 0){
			if (write(fd,&c, 1) != 1){
				int saved_errno = errno;
				close(fd);
				errno = saved_errno;
				errx(1, "Error while writing");
			}
			stats[i]--;
		}
	}
	
	close(fd);
	exit(0);
}
