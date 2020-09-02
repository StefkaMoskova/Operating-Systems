 // cut -d: -f7 /etc/passwd | sort | uniq -c | sort -n

 int main(){

     int fd1[2];
     int fd2[2];
     int fd3[2];

     pipe(fd1);
     pipe(fd2);
     pipe(fd3);

     pid_t cut_pid;
     pid_t sort_pid;
     pid_t uniq_pid;

    if (cut_pid = fork() == -1)
    {
        errx(1, "Error fork cut" );
    }
    
     if (cut_pid == 0)
     {
         close(fd1[0]);

         if (dup2(fd1[1], 1) == -1)
         {
            errx(1, "Error dup2 cut" );
         }

         if (execlp("cut", "cut", "-d:", "-f7", "/etc/passwd", NULL) == -1)
         {
             errx(1, "Error execlp cut" );
         }
         
     }

     close(fd1[1]);

     if (sort_pid = fork() == -1)
     {
         errx(1, "Error fork sort" );
     }
     
     if (sort_pid == 0)
     {
         close(fd2[0]);

         if (dup2(fd1[0], 0) == -1)
         {
            errx(1, "Error dup2 sort 1" );
         }
         
         if (dup2(fd2[1], 1) == -1)
         {
            errx(1, "Error dup2 sort 2" );
         }
         
         if (execlp("sort", "sort", NULL) == -1)
         {
             errx(1, "Error execlp sort" );
         }
     }
     
    close(fd2[1]);

    if (uniq_pid = fork() == -1)
    {
        errx(1, "Error fork uniq" );
    }
    
    if (uniq_pid == 0)
    {
        close(fd3[0]);

        if (dup2(fd2[0], 0) == -1)
        {
            errx(1, "Error dup2 uniq 1");
        }

        if (dup2(fd3[1], 1) == -1)
        {
            errx(1, "Error dup2 uniq 2" );
        }

        if (execlp("uniq", "uniq", "-c", NULL) == -1)
        {
            errx(1, "Error dup2 uniq" );
        }
    }
    
    close(fd3[1]);

    if (dup2(fd3[0],0) == -1)
    {
        errx(1, "Error dup2 last sort" );
    }

    execlp("sort", "sort", "-n", NULL);
    errx(1, "Error execlp last sort" );

    exit (0);
 }