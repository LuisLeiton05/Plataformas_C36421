#include <stdio.h> 
#include <stdlib.h>

int factorial ( int n ) {
    int i = 1;
    while ( n > 1 ) {
        i = i * n;
        n = n - 1; // Aqui quite el int porque sobraba.
    }
    return i;
}



int main ( int argc, char *argv [] ) {
    if (argc != 2) {
        printf("No se proporciono un numero para calcular el factorial.");
        return 1;
    }
    int num1 = atoi(argv[1]);
    int facto = factorial(num1);
    printf("%d! = %d\n", num1, facto);


    return 0;
}