#include "utils.h"

#include <stdlib.h>
#include <time.h>

typedef const char *error_t;

const char alpha[] =
    "abcdefghijklmnopqrstuvwxyz"
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    "1234567890"
    ".,-=+@$^&:;";
const size_t alpha_len = sizeof(alpha) - 1;

bool convert_s_to_i(
    const char *s,
    int *i
) {
    char *p;

    *i = strtol(s, &p, 10);
    return p == s + strlen(s);
}

int read_int(
    const char *prompt,
    error_t *e
) {
    char in[1024];
    int res;

    if (!input(prompt, in, sizeof(in))) {
        *e = "failed to acquire input";
        return 0;
    }
    if (!convert_s_to_i(in, &res)) {
        *e = "failed to convert string to integer";
        return 0;
    }
    return res;
}

error_t handle_error(
    error_t e
) {
    if (e)
        fprintf(stderr, "%s\n", e);
    return e;
}

int main(
    void
) {
    int i, j, len, cnt;
    error_t e = NULL;

    srand(time(NULL));

    len = read_int("password length > ", &e);
    if (handle_error(e))
        return -1;
    cnt = read_int("passwords count > ", &e);
    if (handle_error(e))
        return -1;

    for (i = 0; i < cnt; i++, putchar('\n'))
        for (j = 0; j < len; j++)
            putchar(alpha[rand() % alpha_len]);

    return 0;
}
