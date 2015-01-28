//
//  main.c
//  c_performance
//
//  Created by Patrick Englert on 28.01.15.
//  Copyright (c) 2015 Patrick Englert. All rights reserved.
//

#include <stdio.h>
#include <time.h>

void floats(int times) {
    if (times == 0) {
        return;
    }
    

    
    int n = 10000000;
    float x = 0.999999;
    float a = 1.0;
    clock_t t1 = clock();
    
    for (int i = 0; i <= n; i++) {
        a = a * x;
    }
    clock_t t2 = clock();
    float diff = (((float)t2 - (float)t1) / CLOCKS_PER_SEC ) ;
    printf("floats: %f\n",diff);
    floats(times -1);
}


void twoDimArray(int times) {
    if (times == 0) {
        return;
    }
    
    int arr[180][1000];
    int n = 1000000;
    
    
    clock_t t1 = clock();
    
    for (int i = 0; i < n; i++) {
        arr[i%180][i%1000]++;
    }
    clock_t t2 = clock();
    float diff = (((float)t2 - (float)t1) / CLOCKS_PER_SEC ) ;
    printf("2d: %f\n",diff);
    
    twoDimArray(times -1);
}

void mapped(int times) {
    if (times == 0) {
        return;
    }
    
    int arr[180000];
    int n = 1000000;
    
    
    clock_t t1 = clock();
    
    for (int i = 0; i < n; i++) {
        arr[((i%180) * 1000) + i%1000]++;
    }
    clock_t t2 = clock();
    float diff = (((float)t2 - (float)t1) / CLOCKS_PER_SEC ) ;
    printf("Mapped: %f\n",diff);
    
    mapped(times - 1);
}

void accessing(int times) {
    if (times == 0) {
        return;
    }
    
    int x[1000];
    int n = 1000;
    
    
    clock_t t1 = clock();
    
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            x[i] = x[j]++;
        }
    }
    
    clock_t t2 = clock();
    float diff = (((float)t2 - (float)t1) / CLOCKS_PER_SEC ) ;
    printf("accessing: %f\n",diff);
    
    accessing(times - 1);
}

int main(int argc, const char * argv[]) {
    // insert code here...
    floats(5);
    twoDimArray(5);
    mapped(5);
    accessing(5);
    return 0;
}


