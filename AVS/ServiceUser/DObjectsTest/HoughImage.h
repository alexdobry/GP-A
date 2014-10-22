//
//  HoughImage.h
//  HoughServiceUser
//
//  Created by Alexander Dobrynin on 03.12.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <opencv/cv.h>

@interface HoughImage : NSObject

@property IplImage* img;
@property long imgId;

- (id)initWithIplImage:(IplImage*) img andId:(long) imgId;

@end
