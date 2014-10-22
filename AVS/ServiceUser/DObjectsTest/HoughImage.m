//
//  HoughImage.m
//  HoughServiceUser
//
//  Created by Alexander Dobrynin on 03.12.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "HoughImage.h"

@implementation HoughImage

@synthesize img = _img;
@synthesize imgId = _imgId;

- (id)initWithIplImage:(IplImage*) img andId:(long) imgId {
    self = [super init];
    if (self) {
        self.img = img;
        self.imgId = imgId;
    }
    return self;
}

@end
