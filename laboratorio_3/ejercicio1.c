#include <stdio.h>

int main() {
    int n = 1;
    int triangular = 0;

    while (n <= 100) {
        triangular += n;
        printf("%d\n", triangular);
        n++;
    }

    return 0;
}