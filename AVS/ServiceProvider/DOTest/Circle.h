//
//  Circle.h
//  DOTest
//
//  Created by Alexander Dobrynin on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Circle : NSObject

@property (assign) int x;
@property (assign) int y;
@property (assign) double r;

- (id)initWithX:(int)x y:(int)y r:(double)r;

@end
