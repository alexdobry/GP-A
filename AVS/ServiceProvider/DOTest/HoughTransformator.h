//
//  HoughTransformator.h
//  DOTest
//
//  Created by Alexander Dobrynin on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HoughTransformationProtocol.h"

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <math.h>

@interface HoughTransformator : NSObject <HoughTransformationProtocol>

- (IplImage*)createIplImageFromNSImage:(NSImage *)image;

@end
