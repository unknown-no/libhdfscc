#include "common.h"

#include <stdbool.h>
#include <stdio.h>

void print_hello(const char *name)
{
    bool flag = true;

    printf("Hello, %s %c", name, 0x0A);
    printf("_Bool: %d %c", flag, 0x0A);
}
