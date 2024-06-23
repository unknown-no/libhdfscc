#include "common.h"

#include <iostream>

int main(int argc, char *argv[])
{
    std::cout << "Init" << std::endl;

    print_hello("username");

    std::cout << "Done" << std::endl;

    return 0;
}