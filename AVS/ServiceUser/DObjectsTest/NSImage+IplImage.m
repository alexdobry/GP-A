//
//  NSImage+IplImage.m
//  HoughServiceUser
//
//  Created by Alex on 30.01.14.
//
//

#import "NSImage+IplImage.h"

@implementation NSImage (IplImage)

+ (NSImage*)imageWithIplImage:(IplImage *)image {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // Allocating the buffer for CGImage
    NSData *data =
    [NSData dataWithBytes:image->imageData length:image->imageSize];
    CGDataProviderRef provider =
    CGDataProviderCreateWithCFData((CFDataRef)data);
    // Creating CGImage from chunk of IplImage
    CGImageRef imageRef = CGImageCreate(
                                        image->width, image->height,
                                        image->depth, image->depth * image->nChannels, image->widthStep,
                                        colorSpace, kCGImageAlphaNone|kCGBitmapByteOrderDefault,
                                        provider, NULL, false, kCGRenderingIntentDefault
                                        );
    // Getting UIImage from CGImage
    NSSize size;
    size.height = image->height;
    size.width = image->width;
    NSImage *ret = [[NSImage alloc] initWithCGImage:imageRef size:size];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return ret;
}
@end
