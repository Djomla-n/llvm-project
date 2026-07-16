#include <stdio.h>

int main() {
    int suma = 0;

    for (int i = 5; i < 10; i++) {
        
        if (i == 5) {
            suma += 100;
        } else {
            suma += i;
        }
        
    }

    printf("Suma je: %d\n", suma);
    return 0;
}