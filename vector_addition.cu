#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include <cuda_runtime.h>

// block size
#define BLOCK_SIZE 512
#define VECTOR_SIZE 100 // We can change the value of W to 200, 400, 800, 1600, 3200