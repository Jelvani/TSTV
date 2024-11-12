void s7(int * a, int * b, int * c, int n) {
    if (n < 2) 
    {
    return;
    }
    for (int i = 1; i < n; i++) {
        if(a[0] < b[0]) {
            c[i] += 1;
            b[i] += 1;
        }
        else {
            a[i] += 1;
        }
    }
}


int main(){
    return 0;
}