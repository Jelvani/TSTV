// TODO: replace manual checks with __builtin_unreachable()
// for unreachable state. Later... C23 adds standard support 
// for unreachable().

// software pipelining
void s1(int *__restrict a, int *__restrict b, int *__restrict  c, int n) {
    int i = 0;
    while (i < n) {
        a[i] += 1;
        b[i] += a[i];
        c[i] += b[i];
        i++;
    }
}

void t1(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    a[0] += 1;
    b[0] += a[0];
    a[1] += 1;
    int i = 0;
    while (i < n - 2) {
        a[i+2] += 1;
        b[i+1] += a[i+1];
        c[i] += b[i];
        i++;
    }
    c[i] += b[i];
    b[i+1] += a[i+1];
    c[i+1] += b[i+1];
}


// loop unrolling
void s2(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    if (n <= 5) return;
    for (int i = 0; i < n; i++) {
        a[i] = b[i] + c[i];
    }
}

void t2(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    if (n <= 5) return;
    int i = 0;

    for (; i < n - 5; i+=5) {
        a[i] = b[i] + c[i];
        a[i+1] = b[i+1] + c[i+1];
        a[i+2] = b[i+2] + c[i+2];
        a[i+3] = b[i+3] + c[i+3];
        a[i+4] = b[i+4] + c[i+4];
    }

    for (; i < n; i++) {
        a[i] = b[i] + c[i];
    }
}

// loop fusion
void s3(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    for (int i = 0; i < n; i++) {
        a[i] += c[i];
    }
    for (int i = 0; i < n; i++) {
        b[i] += c[i];
    }
}

void t3(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    for (int i = 0; i < n; i++) {
        a[i] += c[i];
        b[i] += c[i];
    }
}

// loop fission
void s4(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    for (int i = 0; i < n; i++) {
        a[i] += 1;
        b[i] += a[i];
        c[i] += b[i];
    }
}

void t4(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    for (int i = 0; i < n; i++) {
        a[i] += 1;
    }
        for (int i = 0; i < n; i++) {
        b[i] += a[i];
    }
        for (int i = 0; i < n; i++) {
        c[i] += b[i];
    }
}

// loop peeling
void s5(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    if (n < 2) return;

    for (int i = 0; i < n; i++) {
        a[i] += b[i] + c[i];
    }
}

void t5(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    if (n < 2) return;

    a[0] += b[0] + c[0];
    a[1] += b[1] + c[1];
    for (int i = 2; i < n; i++) {
        a[i] += b[i] + c[i];
    }
}

// loop interchange
void s6(int *__restrict a, int **__restrict b, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            a[j] += b[i][j] + 1;
        }
    }
}

void t6(int *__restrict a, int **__restrict b, int n) {
    for (int j = 0; j < n; j++) {
        for (int i = 0; i < n; i++) {
            a[j] += b[j][i] + 1;
        }
    }
}

// loop tiling



// loop unswitching
void s7(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    if (n < 2) return;

    for (int i = 1; i < n; i++) {
        if(a[0] < b[0]) {
            c[i] += 1;
        }
        else {
            a[i] += 1;
        }
    }
}

void t7(int *__restrict a, int *__restrict b, int *__restrict c, int n) {
    if (n < 2) return;

    if(a[0] < b[0]) {
        for (int i = 1; i < n; i++) {
            c[i] += 1;
        }
    }
    else {
        for (int i = 1; i < n; i++) {
            a[i] += 1;
        }
        
    }
}

// loop-invariant code motion
void s8(int *__restrict a, int *__restrict b, int n) {
    if (n < 1) return;
    int i = 0;
    while (i < n) {
        a[0] = b[0];
        a[i] += a[0];
        b[i] += b[0];
        i++;
    }
}

void t8(int *__restrict a, int *__restrict b, int n) {
    if (n < 1) return;
    int i = 0;
    if(i < n) {
        a[0] = b[0];
    }
    do {
        a[i] += a[0];
        b[i] += b[0];
        i++;
    } while (i < n);
}