//
//  HoughTransformationProtocol.h
//  DObjectsTest
//
//  Created by Alexander Dobrynin on 26.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <opencv/cv.h>

@protocol HoughTransformationProtocol <NSObject>

- (NSMutableArray*) performHoughTransformationWithImageUrl:(NSString*) imageUrl;
- (NSMutableArray*) performHoughTransformationWithIplImage:(IplImage*) iplImage;
- (NSMutableArray*) performHoughTransformationWithNSImage:(NSImage*) img;

@end
