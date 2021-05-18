#pragma once

#include <stddef.h>
#include <stdio.h>
#include <string.h>

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
