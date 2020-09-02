#include <unistd.h>
#include <err.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

int main()
{
    int waitStatus;
    char cmd[32];
    int i = 0;

    while (1){
        write(1, "> ", 2);
        while ((read(0, &cmd[i], 1)) && cmd[i] != "\n"){
            if (cmd[i] == ' ' || cmd == '\t'){
                continue;
            }

            else
            {
                i++;
            } 
        }
        
        if (cmd[i] == '/n')
        {
            cmd[i] = '\0';
        }
        
        if (strcmp(cmd, "exit") == 0)
        {
            exit(0);
        }

        else {
            if(fork ())
            {
                wait(&waitStatus);
                i=0;
            }
            
            else
            {
                if (execlp(cmd, cmd, NULL) < 0)
                {
                    printf("Cannot execute %s\n", cmd);
                    exit(1);
                }
                
            }
        }
        
    }
}


