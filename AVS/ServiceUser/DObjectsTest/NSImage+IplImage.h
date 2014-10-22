//
//  NSImage+IplImage.h
//  HoughServiceUser
//
//  Created by Alex on 30.01.14.
//
//

#import <Cocoa/Cocoa.h>
#include <opencv/cv.h>

@interface NSImage (IplImage)

+ (NSImage*)imageWithIplImage:(IplImage *)image;

@end
