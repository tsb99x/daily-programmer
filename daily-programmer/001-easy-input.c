#include "utils.h"

#define LENGTH 256

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
