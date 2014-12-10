//
//  main.m
//  Call by reference
//
//  Created by Stefan Heruth on 03.12.14.
//  Copyright (c) 2014 Stefan Heruth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SampleClass:NSObject
/* method declaration */
- (void)swap:(int *)num1 andNum2:(int *)num2;
@end

@implementation SampleClass

- (void)swap:(int *)a andNum2:(int *)b
{
    int temporaryA;
    
    temporaryA = *a; /* save the value of num1 */
    *a = *b;    /* put num2 into num1 */
    *b = temporaryA; /* put temp into num2 */
    
    return;
    
}

@end

int main ()
{
    /* local variable definition */
    int someInt = 3;
    int anotherInt = 44;
    
    SampleClass *sampleClass = [[SampleClass alloc]init];
    
    NSLog(@"Before swap, value of a : %d\n", someInt );
    NSLog(@"Before swap, value of b : %d\n", anotherInt );
    
    /* calling a function to swap the values */
    [sampleClass swap:&someInt andNum2:&anotherInt];
    
    NSLog(@"After swap, value of a : %d\n", someInt );
    NSLog(@"After swap, value of b : %d\n", anotherInt );
    
    return 0;
}

