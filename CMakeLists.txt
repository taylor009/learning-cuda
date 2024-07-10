cmake_minimum_required(VERSION 3.28)
project(learning_cuda CUDA)

set(CMAKE_CUDA_COMPILER /usr/local/cuda-12/bin/nvcc)
set(CMAKE_CUDA_ARCHITECTURES 86)
set(CMAKE_CUDA_STANDARD 17)

add_executable(learning_cuda hello_world.cu addition.cu vector_addition.cu)

set_target_properties(learning_cuda PROPERTIES
        CUDA_SEPARABLE_COMPILATION ON)