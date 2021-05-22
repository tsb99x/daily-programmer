#include "utils.h"

#define LENGTH 256

char read_mode(
    const char *in
) {
    if (!strcmp(in, "f"))
        return 'f';
    if (!strcmp(in, "m"))
        return 'm';
    if (!strcmp(in, "a"))
        return 'a';
    return 0;
}

void read_params(
    char mode,
    float *f,
    float *m,
    float *a
) {
    if (mode == 'm' || mode == 'a') {
        printf("input value of [f] > ");
        scanf("%f", f);
    }
    if (mode == 'f' || mode == 'a') {
        printf("input value of [m] > ");
        scanf("%f", m);
    }
    if (mode == 'f' || mode == 'm') {
        printf("input value of [a] > ");
        scanf("%f", a);
    }
}

float calc(
    char mode,
    float f,
    float m,
    float a
) {
    if (mode == 'f')
        return m * a;
    if (mode == 'm')
        return f / a;
    if (mode == 'a')
        return f / m;
}

int main(
    void
) {
    char mode, in[LENGTH];
    float f, m, a;

    if (!input("choose input mode [f] = [m] * [a] > ", in, LENGTH)) {
        fputs("failed to acquire input\n", stderr);
        return -1;
    }

    mode = read_mode(in);
    if (!mode) {
        fputs("only [f], [m], or [a] modes are allowed\n", stderr);
        return -1;
    }

    read_params(mode, &f, &m, &a);
    printf("[%c] = %f\n", mode, calc(mode, f, m, a));

    return 0;
}
