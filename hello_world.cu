#include <stdio.h>

// Declare the function defined in addition.cu
void performAddition(int a, int b, int *c);

void vectorAddition();

int main(void) {
    int a = 3;
    int b = 7;
    int c;

    // Perform addition using CUDA
    // performAddition(a, b, &c);
    vectorAddition();

    // Print the result
    printf("%d\n", c);

    return 0;
}