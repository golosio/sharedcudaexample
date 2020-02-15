CC=g++
NVCC=nvcc
CXXFLAGS= -O3 -Wall -fPIC
CUDAFLAGS= -arch sm_30 --ptxas-options=-v --relocatable-device-code true
LIBS= -lm
LDFLAGS = -shared   # linking flags

RM = rm -f   # rm command
TARGET_LIB = ./lib/libsharedcuda.so  # target lib

SRC_DIR   = src

SRC_FILES  = $(wildcard $(SRC_DIR)/*.cu)
SRC_FILES += $(wildcard $(SRC_DIR)/*.cpp)

H_FILES   = $(wildcard $(SRC_DIR)/*.h)
H_FILES += $(wildcard $(SRC_DIR)/*.cuh)

.PHONY: all
all: ${TARGET_LIB}

$(TARGET_LIB): $(SRC_FILES)
	$(NVCC) -ccbin=${CC} --compiler-options  '${CXXFLAGS}' ${CUDAFLAGS} ${LDFLAGS} -o $@ $^

.PHONY: clean
clean:
	-${RM} ${TARGET_LIB}
