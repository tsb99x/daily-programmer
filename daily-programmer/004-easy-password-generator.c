#include "utils.h"

#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

void panic(
    const char *msg
) {
    fputs(msg, stderr);
    fputc('\n', stderr);
    exit(EXIT_FAILURE);
}

bool convert_s_to_i(
    const char *s,
    int *i
) {
    char *p;

    *i = strtol(s, &p, 10);
    return p == s + strlen(s);
}

int read_int(
    const char *prompt
) {
    char in[1024];
    int res;

    if (!input(prompt, in, sizeof(in)))
        panic("failed to acquire input");
    if (!convert_s_to_i(in, &res))
        panic("failed to convert string to integer");
    return res;
}

int main(
    void
) {
    int i, j, len, cnt, alpha_len;
    const char alpha[] =
        "abcdefghijklmnopqrstuvwxyz"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "1234567890"
        ".,-=+@$^&:;";

    srand(time(NULL));

    len = read_int("password length > ");
    cnt = read_int("passwords count > ");

    alpha_len = strlen(alpha);
    for (i = 0; i < cnt; i++, putchar('\n'))
        for (j = 0; j < len; j++)
            putchar(alpha[rand() % alpha_len]);

    return EXIT_SUCCESS;
}
