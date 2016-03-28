#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

int
main (int argc, char *argv[])
{
   setuid (0);

   /* WARNING: Only use an absolute path to the script to execute,
    *          a malicious user might fool the binary and execute
    *          arbitary commands if not.
    * */

   char* command = "/bin/sh /home/pi/SKAD/scripts/php_shell.sh";

   if (argc > 1) {
         char* tmpString = malloc(strlen(command)+1+strlen(argv[0])+1);
         strcpy(tmpString, command);
         strcat(tmpString, " ");
         strcat(tmpString, argv[1]);
         strcat(tmpString, " ");
         strcat(tmpString, argv[2]);
         command = tmpString;
   }

   system(command);

   return 0;
}
