#include "utils.h"

#define BUF_SIZE 1024

char rotcb(
    char c,
    char base,
    int shift,
    int alpha_len
) {
    return base + (c - base + shift) % alpha_len;
}

char rotc(
    char c,
    int shift
) {
    if (c >= 'a' && c <= 'z')
        return rotcb(c, 'a', shift, 26);
    if (c >= 'A' && c <= 'Z')
        return rotcb(c, 'A', shift, 26);
    return c;
}

void rots(
    char *s,
    int shift
) {
    while (*s)
        *s++ = rotc(*s, shift);
}

int main(
    void
) {
    char in[BUF_SIZE];

    if (!input("string to encode > ", in, sizeof(in))) {
        fputs("failed to acquire input\n", stderr);
        return -1;
    }

    rots(in, 13);
    printf("rot13 is '%s'\n", in);
    rots(in, 13);
    printf("rot13 is '%s'\n", in);
    return 0;
}
