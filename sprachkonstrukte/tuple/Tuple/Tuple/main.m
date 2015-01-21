//
//  main.m
//  Tuple
//
//  Created by Stefan Heruth on 03.12.14.
//  Copyright (c) 2014 Stefan Heruth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleClass.h"
#import "SampleClass.m"



int main(int argc, const char * argv[]) {
    
    
   NSArray *nichtaenderbar = @[@"Hello World", @ 4];
   SampleClass *sampleclass = [[SampleClass alloc]init];
   NSMutableArray* result = [sampleclass getMultipleValues];
  
   NSString *boolVar = result[1];
    
  [result replaceObjectAtIndex:0 withObject: @"Bye"];

    
    return 0;
}




