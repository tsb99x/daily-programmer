#include <stddef.h>
#include <stdio.h>

#define ARR_SIZE 1024

int *find_index(
    int val,
    int *arr,
    size_t arr_size
) {
    int lo = 0;
    int hi = arr_size - 1;

    while (lo <= hi) {
        int mi = (lo + hi) / 2;

        if (arr[mi] == val)
            return arr + mi;
        if (arr[mi] > val)
            hi = mi - 1;
        if (arr[mi] < val)
            lo = mi + 1;
    }
    return NULL;
}

int main(
    void
) {
    int arr[] = { 1, 3, 5, 8, 12 };
    size_t arr_size = sizeof(arr) / sizeof(*arr);
    int *res;

    res = find_index(8, arr, arr_size);
    printf("%d is %sfound in array\n", 8, !res ? "not " : "");
    return 0;
}
