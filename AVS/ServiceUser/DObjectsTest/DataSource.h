//
//  DataSource.h
//  DObjectsTest
//
//  Created by Markus Müller on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HoughImage.h"

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <math.h>

@interface DataSource : NSObject

@property CvCapture *capture;
@property long counter;
@property long lastShownImageId;

-(HoughImage*)getNextDataset;
-(bool)showImage:(HoughImage*) houghImg;

@end
