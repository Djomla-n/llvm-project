#include <stdio.h>

int main()
{
    int n = 7;
    int a[] = {2, 3, 1, -5, -4, 3, 2};
    for (int i = 0; i < n; i++) {
        if (a[i] < 0)
            a[i] = 0;
        else
            a[i] = i*2;
}
    return 0;
}