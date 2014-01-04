#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main (int argc, char *argv[])
{
   FILE *fp;
   long fsize;
   long i;
   char *src;
   char *dest;
   char version[] = "Plaintext Log Wiper v1.0 by XT [DuHo]";

   printf("%s\n\n", version);

   if (argc<3)
    {
      printf("Syntax: %s <pattern> <logfile>\n", argv[0]);
      exit(0);
    }

   // open file read-only
   if ((fp = fopen(argv[2], "r"))==NULL)
    {
      fprintf(stderr, "Unable to open %s\n", argv[2]);
      exit(1);
    }

   // Is there any more direct way to determine filesize?
   fseek(fp, 0L, SEEK_END);
    if ((fsize = ftell(fp))<1)
     {
       fprintf(stderr, "%s is empty or an error occurred\n", argv[2]);
       exit(1);
     } else
          rewind(fp);

    // allocate enough memory
    src = (char *) malloc((size_t)fsize);
    dest = (char *) malloc((size_t)fsize);

   // select lines to remove
   for (i=0;(fgets(src, fsize, fp))!=NULL;)
    {
       if ((strstr(src, argv[1]))==NULL)
        {
          strncat(dest, src, (size_t)fsize);
        } else
           {
             printf("Selected: %s", src);
             ++i;
           }
    }

   // reopen file write-only
   if ((fp = freopen(argv[2], "w", fp))==NULL)
    {
      fprintf(stderr, "\nUnable to open file %s for writing\n", argv[2]);
      exit(1);
    }

   // write new logfile to disk
   if (fputs(dest, fp)<0)
    {
      fprintf(stderr, "\nUnable to overwrite file %s\n", argv[2]);
      exit(1);
    } else if (i>0)
         printf("\nSuccesfully removed %d %s!\n", i, i==1 ? "log-entry" : "log-entries");
      else
         printf("\"%s\" not found in %s\n", argv[1], argv[2]);

   fclose(fp);
   exit(0);
}  

