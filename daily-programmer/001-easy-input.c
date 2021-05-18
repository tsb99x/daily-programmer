/*

    https://www.reddit.com/r/dailyprogrammer/comments/pih8x/easy_challenge_1/

    [easy] challenge #1

    create a program that will ask the users name, age, and reddit username.
    have it tell them the information back, in the format:

        your name is (blank), you are (blank) years old, and your username is (blank)

    for extra credit, have the program log this information in a file to be accessed later.

*/

#include <stdio.h>
#include <string.h>

#define LENGTH 256

void input(
    const char *prompt,
    char *dest,
    size_t dest_size
) {
    size_t len;

    fputs(prompt, stdout);
    fgets(dest, dest_size, stdin);
    len = strlen(dest);
    if (len-- && dest[len] == '\n')
        dest[len] = '\0';
}

int main(
    void
) {
    const char format[] = "your name is %s, you are %s years old, and your username is %s\n";
    char name[LENGTH], age[LENGTH], username[LENGTH];
    FILE *log;

    input("input your name > ", name, LENGTH);
    input("input your age > ", age, LENGTH);
    input("input your username > ", username, LENGTH);

    printf(format, name, age, username);

    log = fopen("tmp/log.txt", "a");
    if (!log) {
        fputs("could not open file log.txt\n", stderr);
        return -1;
    }
    fprintf(log, format, name, age, username);
    fclose(log);

    return 0;
}
