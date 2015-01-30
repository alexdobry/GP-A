//
//  SampleClass.m
//  Tuple
//
//  Created by Stefan Heruth on 21.01.15.
//  Copyright (c) 2015 Stefan Heruth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SampleClass.h"

@implementation SampleClass

// function mit array rückgabewert
- (NSArray*)getMultipleValues{
 
    NSMutableArray *aenderbar =[NSMutableArray array];
    [aenderbar addObject:@"Willkommen"];
    [aenderbar addObject:@ 123456789.3];
    [aenderbar addObject:@ TRUE];

    return aenderbar;
}
@end







