#include <stdio.h>

/* This is a hello world program */
int main(int argc, char *argv[])
{
    printf("Hello world\n");
    printf("args:\n");
    while(argc--)
        printf("%s\n",*argv++);

    return 0;
}
