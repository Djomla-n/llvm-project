#include <stdio.h>
#include <stdlib.h>
#define MAX 100

int main() {

    int x, n;
    int y = 0;

    /*if (x > 0) {
        for (int i = 0; i < n; i++) {
            y--;
        }
    }
    else {
        for (int i = 0; i < n; i++) {
            y++;
        }
    }*/

    for (int i = 0; i < n; i++) {
        if (x > 0) {
            y--;
        }
        else {
            y++;
        }
    }

    return 0;
}
