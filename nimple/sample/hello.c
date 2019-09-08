#include <stdio.h>

typedef struct {
    int x;
    float y;
} STRUC;

STRUC some;

int sum(int a, float b) { return a+b; }

STRUC* flo(int a, float b) { some.x = a; some.y = b; return &some; }

int main() { printf("hello"); }
