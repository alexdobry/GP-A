//
//  Circle.m
//  DObjectsTest
//
//  Created by Alexander Dobrynin on 26.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Circle.h"

@implementation Circle

@synthesize x = _x;
@synthesize y = _y;
@synthesize r = _r;

- (id)init {
    self = [super init];
    if (self) {
        self.x = 0;
        self.y = 0;
        self.r = 0;
    }
    return self;
}

- (id)initWithX:(int)x y:(int)y r:(double)r {
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
        self.r = r;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x = %d, y = %d, r = %.2lf", self.x, self.y, self.r];
}

@end
