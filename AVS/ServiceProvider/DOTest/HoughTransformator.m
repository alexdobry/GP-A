//
//  HoughTransformator.m
//  DOTest
//
//  Created by Alexander Dobrynin on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "HoughTransformator.h"
#import "Circle.h"
#include <opencv/cv.h>

@implementation HoughTransformator

- (NSMutableArray*)performHoughTransformationWithImageUrl:(NSString*) imageUrl {
    
    // Load Image from local storage
    IplImage *src = cvLoadImage([imageUrl UTF8String], CV_LOAD_IMAGE_UNCHANGED);
    // output image (dst) of the same size and depth @"as src.
    IplImage *dst = cvCreateImage(cvSize(src->width, src->height), src->depth, 0);
    
    // Converts an image from one color space to another (gray).
    cvCvtColor(src, dst, CV_BGR2GRAY);
    
    // using cvSmooth instead of GaussianBlur to smooth the image, otherwise a lot of false circles may be detected
    // src, dst, smoothType, density width, density height, sigma 1, sigma 2
    // density -> Je höher desto feiner
    cvSmooth(dst, dst, CV_GAUSSIAN, 11, 11, 0, 0);
    
    // Finds circles in a grayscale image using the Hough transform.
    // src, storage that will contain the output sequence of found circles, detection method, example code, example code, example code, example code, min, max      mindist dst->height/4
    CvMemStorage* storage = cvCreateMemStorage(0);
    CvSeq* result = cvHoughCircles(dst, storage, CV_HOUGH_GRADIENT, 2, 100, 200, 100, 30, 120);
    NSLog(@"total: %d", result->total);
    
    NSMutableArray* circles = [[NSMutableArray alloc] initWithCapacity:result->total];
    for (int i = 0; i < result->total; i++) {
        // returns a pointer (float array) to a sequence element according to its index.
        // x = [0], y = [1], r = [2]
        float *detectedCircle = (float*) cvGetSeqElem(result, i);
        NSLog(@"x = %f, y = %f, r = %f", detectedCircle[0], detectedCircle[1], detectedCircle[2]);
        
        // Draws a circle
        // src, center (combination of x and y), radius, color (red), thickness, example code, example code
        // cvCircle(src, cvPoint(cvRound(detectedCircle[0]),cvRound(detectedCircle[1])), cvRound(detectedCircle[2]), CV_RGB(255,0,0), 3, 8, 0);
        [circles addObject:[[Circle alloc] initWithX:detectedCircle[0] y:detectedCircle[1] r:detectedCircle[2]]];
    }
    
    //cvSaveImage("/Users/alexdobry/Desktop/Foto.png", src, 0);
    
    // Remember to free image memory after using it!
    cvReleaseMemStorage(&storage);
    cvReleaseImage(&dst);
    cvReleaseImage(&src);
    
    return circles;
    
    //Einflussfaktoren auf die Anzahl der Ergebnisse der Hough Transformation
    //Funktion cvHoguhcircles  
    //  -> min/max radius --> Spanne, welche Größe die Kreise haben dürfen 
    //  -> mindist --> Spanne zwischen den Kreismittelpunkten 
    //Bei münzen mindist = 100 und min 30 und max 120 relativ gutes ergebnis

}

- (NSMutableArray*) performHoughTransformationWithIplImage:(IplImage*) src {
//    IplImage *dst = cvCreateImage(cvSize(src->width, src->height), src->depth, 0);
//    cvCvtColor(src, dst, CV_BGR2GRAY);
//    cvSmooth(dst, dst, CV_GAUSSIAN, 11, 11, 0, 0);
//    
//    CvMemStorage* storage = cvCreateMemStorage(0);
//    CvSeq* result = cvHoughCircles(dst, storage, CV_HOUGH_GRADIENT, 2, 100, 200, 100, 30, 120);
//    NSLog(@"total: %d", result->total);
//    
//    NSMutableArray* circles = [[NSMutableArray alloc] initWithCapacity:result->total];
//    for (int i = 0; i < result->total; i++) {
//        float *detectedCircle = (float*) cvGetSeqElem(result, i);
//        NSLog(@"x = %f, y = %f, r = %f", detectedCircle[0], detectedCircle[1], detectedCircle[2]);
//        [circles addObject:[[Circle alloc] initWithX:detectedCircle[0] y:detectedCircle[1] r:detectedCircle[2]]];
//    }
//    
//    cvReleaseImageHeader(&dst);
//    cvReleaseMemStorage(&storage);
//    return [circles autorelease];
    NSLog(@"performHoughTransformationWithIplImage");
    return nil;
}

- (NSMutableArray*) performHoughTransformationWithNSImage:(NSImage*) img {
    NSLog(@"performHoughTransformationWithNSImage");    
    IplImage* src = [self createIplImageFromNSImage:img];
    
    IplImage *dst = cvCreateImage(cvSize(src->width, src->height), src->depth, 0);
    cvCvtColor(src, dst, CV_BGR2GRAY);
    cvSmooth(dst, dst, CV_GAUSSIAN, 11, 11, 0, 0);
        
    CvMemStorage* storage = cvCreateMemStorage(0);
    CvSeq* result = cvHoughCircles(dst, storage, CV_HOUGH_GRADIENT, 2, 100, 200, 100, 30, 120);
    NSLog(@"total: %d", result->total);
     
    NSMutableArray* circles = [[NSMutableArray alloc] initWithCapacity:result->total];
    
    for (int i = 0; i < result->total; i++) {
        float *detectedCircle = (float*) cvGetSeqElem(result, i);
        NSLog(@"x = %f, y = %f, r = %f", detectedCircle[0], detectedCircle[1], detectedCircle[2]);
        [circles addObject:[[Circle alloc] initWithX:detectedCircle[0] y:detectedCircle[1] r:detectedCircle[2]]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logger" object:[NSString stringWithFormat:@"x = %f, y = %f, r = %f", detectedCircle[0], detectedCircle[1], detectedCircle[2]]];
    }
    
    cvReleaseImageHeader(&dst);
    cvReleaseMemStorage(&storage);
    return [circles autorelease];
}

- (IplImage*)createIplImageFromNSImage:(NSImage*)img {	
    NSBitmapImageRep *bitmap2 = [NSBitmapImageRep imageRepWithData:[img TIFFRepresentation]];
    NSImage* bild1 = [[NSImage alloc] initWithSize:NSMakeSize([bitmap2 pixelsWide],[bitmap2 pixelsHigh])];
    
    int depth       = (int) [bitmap2 bitsPerSample];
    int channels    = (int) [bitmap2 samplesPerPixel];
    int height      = [bild1 size].height;
    int width       = [bild1 size].width;
    
    
    IplImage *iplpic = cvCreateImage(cvSize(  width,height), depth, channels);
    cvSetImageData(iplpic, [bitmap2 bitmapData], [bitmap2 bytesPerRow]);
	return iplpic;
}

@end
