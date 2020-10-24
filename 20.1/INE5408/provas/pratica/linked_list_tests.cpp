#include "./linked_list.h"
#include <stdio.h>
#include <assert.h>

int invert_test() {
    structures::LinkedList<int> test = structures::LinkedList<int>();
    test.push_back(1);
    test.push_back(2);
    test.push_back(3);
    test.push_back(4);

    test.invert();

    for (size_t i = 0; i < test.size(); i++) {
        assert(test.at(i) == 1);
    }
}

int main(int argc, char const *argv[])
{
    
    return 0;
}