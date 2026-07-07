int main() {

    int a, b = 0;
    int n;

    /*if (a > 0) {
        for (int i = 0; i < n; i++) {
            b -= 2;
        }
    }
    else {
        for (int i = 0; i < n; i++) {
            b += 3;
        }
    }*/

    for (int i = 0; i < n; i++) {
        if (a > 0) 
            b -= 2;
        else
            b += 3;
    }

    return 0;
}
