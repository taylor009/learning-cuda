#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include <cuda_runtime.h>

// block size
#define BLOCK_SIZE 512
#define VECTOR_SIZE 100 // We can change the value of W to 200, 400, 800, 1600, 3200

// Allocates a vector with random float entries

void randomInit(float* data, int n)
{
    for (int i = 0; i < n; ++i)
    {
        data[i] = rand() / (float)RAND_MAX;
    }
}

__global__ void VectorAdd(float* Md, float* Nd, float* Pd) {
    // Calculate the index of the Pd element and M and N
    int index = blockIdx.x * BLOCK_SIZE + threadIdx.x;

    // Each thread computes one element of the block sub-vector
    Pd[index] = Md[index] + Nd[index];
}

void vectorAddition() {
   srand(2006);
    double time;
    clock_t stime = clock();
    clock_t etime;

    // Allocate host memory for vectors A and B
    unsigned int size_A = VECTOR_SIZE;
    unsigned int mem_size_A = sizeof(float) * size_A;
    float* h_A = (float*)malloc(mem_size_A);

    unsigned int size_B = VECTOR_SIZE;
    unsigned int mem_size_B = sizeof(float) * size_B;
    float* h_B = (float*)malloc(mem_size_B);

    // Initialize host memory
    randomInit(h_A, size_A);
    randomInit(h_B, size_B);

    // allocate device memory
    float* d_A;
    cudaMalloc((void**)&d_A, mem_size_A);

    float* d_B;
    cudaMalloc((void**)&d_B, mem_size_B);

    // copy host memory to device
    cudaMemcpy(d_A, h_A, mem_size_A, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, mem_size_B, cudaMemcpyHostToDevice);

    // allocate device memory for result
    unsigned int size_C = VECTOR_SIZE;
    unsigned int mem_size_C = sizeof(float) * size_C;

    float* d_C;
    cudaMalloc((void**)&d_C, mem_size_C);

    // setup execution parameters
    dim3 threads(1, BLOCK_SIZE);
    dim3 grid(VECTOR_SIZE / threads.x, threads.y);

    // execute the kernal
    VectorAdd <<< grid, threads >>> (d_A, d_B, d_C);

    cudaDeviceSynchronize();

    // allocate host memory for the result
    float* h_C = (float*)malloc(mem_size_C);

    // copy result from device to host
    cudaMemcpy(h_C, d_C, mem_size_C, cudaMemcpyDeviceToHost);

    // cleanup memory
    free(h_A);
    free(h_B);
    free(h_C);
}