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
    
   // generisches array als tuple
   NSArray *tupel = @[@"Hello World", @ 4];
   SampleClass *sampleclass = [[SampleClass alloc]init];
   NSArray* result = [sampleclass getMultipleValues];
  
   // ansprechen
   result[0]
   result[1]
   NSString *boolVar = result[1];
    
  [result replaceObjectAtIndex:0 withObject: @"Bye"];

    
    return 0;
}




