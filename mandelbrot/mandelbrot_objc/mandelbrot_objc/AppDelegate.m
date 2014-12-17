//
//  AppDelegate.m
//  mandelbrot_objc
//
//  Created by Patrick Englert on 10.12.14.
//  Copyright (c) 2014 Patrick Englert. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreGraphics/CoreGraphics.h>
@interface AppDelegate ()

@property (weak) IBOutlet NSImageView *view;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    //CGSize cgsize = CGSizeMake(3860, 3860);
    
     NSImage *img = [[NSImage alloc] initWithSize: NSMakeSize(300, 300)];
     
     [img lockFocus];
     
     NSColor *black = [NSColor blackColor];
     [black setFill];
     NSRectFill(NSMakeRect(0, 0, 300, 300));
     [img unlockFocus];
     
     _view.image = img;
    
     // imgData = img.TIFFRepresentation
     //        var imgSource: CGImageSource = CGImageSourceCreateWithData(imgData, nil)
     //        var cgimg: CGImage = CGImageSourceCreateImageAtIndex(imgSource, 0, nil)
     //
     //        var pointer = UnsafeMutablePointer<Void>.alloc(300*200*4)
     //
     //        var imgref = CGBitmapContextCreate(pointer, 300, 200, 8, 4*300, CGColorSpaceCreateDeviceRGB(),
     //            CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue))
     //
     //
     //        CGContextDrawImage(imgref, NSMakeRect(0, 0, 300, 200), cgimg)
     
     //        CGContextRef ctx;
     //        CGImageRef imageRef = [self.workingImage CGImage];
     //        NSUInteger width = CGImageGetWidth(imageRef);
     //        NSUInteger height = CGImageGetHeight(imageRef);
     //        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     //        unsigned char *rawData = malloc(height * width * 4);
     //        NSUInteger bytesPerPixel = 4;
     //        NSUInteger bytesPerRow = bytesPerPixel * width;
     //        NSUInteger bitsPerComponent = 8;
     //        CGContextRef context = CGBitmapContextCreate(rawData, width, height,
     //            bitsPerComponent, bytesPerRow, colorSpace,
     //            kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
     //        CGColorSpaceRelease(colorSpace);
     //
     //        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
     //        CGContextRelease(context);
     
     NSData *imgData = [img TIFFRepresentation];
     CFDataRef bla = CFDataCreate(NULL, [imgData bytes], [imgData length]);
     struct CGImageSource *imgSource = CGImageSourceCreateWithData(bla, nil);
     struct CGImage *cgimg = CGImageSourceCreateImageAtIndex(imgSource, 0, nil);
    
    unsigned long width = CGImageGetWidth(cgimg);
    unsigned long height = CGImageGetHeight(cgimg);
    float f_height = (float) height;
    float f_width = (float) width;
    
    //NSColorSpace *colorSpace = CFBridgingRelease(CGColorSpaceCreateDeviceRGB());
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    
    
    unsigned int bytesPerPixel = 4;
    unsigned int bytesPerRow = bytesPerPixel * (int) width;
    unsigned int bitsPerComponent = 8;
    
     CGContextRef context = CGBitmapContextCreate(rawData,
                                                  width,
                                                  height,
                                                  bitsPerComponent,
                                                  bytesPerRow,
                                                  rgbColorSpace,
                                                  (CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    
    CGFloat cg_width = (CGFloat) width;
    CGFloat cg_height = (CGFloat) height;
    CGContextDrawImage(context, CGRectMake(0, 0, cg_width, cg_height), cgimg);
    int bufferindex = 0;
    int max_iteration = 1000;
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
     
    for (int i = 0; i < max_iteration; i++) {
//        NSColor *color = [NSColor colorWithCalibratedHue:(i/255) saturation:1 brightness:i/(i+8) alpha:255];
        NSColor *color = [NSColor colorWithRed:0.5 green:0.2 blue:0.9 alpha:1.0];
        CGFloat *u_r = malloc(sizeof(CGFloat));
        CGFloat *u_g = malloc(sizeof(CGFloat));
        CGFloat *u_b = malloc(sizeof(CGFloat));
        CGFloat *u_a = malloc(sizeof(CGFloat));
        
        [color getRed:u_r green:u_g blue:u_b alpha:u_a];
        NSLog(@"%f %f %f", color.redComponent, *u_g, *u_b);
        [colors addObject: color];
        
    }
     
    
     
    NSDate *start = [NSDate date];
     //draw stuff
     
    for (int px = 1;  px <= height; px++) {
         for (int py = 1;  py <= width; py++) {
             float y0 = ((px - (f_width/2.0)) * 4.0 / f_width );// / 110) - 0.65  //* complexPlaneWidth + complexPlaneLeftEdgeCoord
             float x0 = (py - (f_height/2.0)) * 4.0 / f_height; // / 110) + 0.35
             
             float x = 0.0;
             float y = 0.0;
             
             int iteration = 0;
             
             
             while ((x * x + y * y <= 4) && iteration < max_iteration) {
                 float xtemp = x * x  - y * y + x0;
                 y = 2 * x * y + y0;
                 x = xtemp;
                 iteration++;
             }
             
             
             if (iteration < max_iteration) {
                 CGFloat *u_r = malloc(1);
                 CGFloat *u_g = malloc(1);
                 CGFloat *u_b = malloc(1);
                 CGFloat *u_a = malloc(1);
                 [colors[iteration] getRed:u_r green:u_g blue:u_b alpha:u_a];
                 //                    r = colors[iteration].redComponent
                 //                    g = colors[iteration].greenComponent
                 //                    b = colors[iteration].blackComponent
                 //NSLog(@"%f %f %f", u_r, u_g, u_b);
                 rawData[bufferindex] =  (char) (*u_r * 255.0);
                 rawData[bufferindex + 1] = (char) (*u_g * 255);
                 rawData[bufferindex + 2] = (char) (*u_b * 255);
             
             } else {
                 rawData[bufferindex] = 0;
                 rawData[bufferindex + 1] = 0;
                 rawData[bufferindex + 2] = 0;
         }
         //println("Writing \(px) \(py) \(bufferindex)")
     
             bufferindex += 4;
     
     }
     
     
     }
    NSDate *end = [NSDate date];
    NSLog(@"%f", [end timeIntervalSinceDate:start]);
     //write new img
     //        var newimg : CGImage = CGBitmapContextCreateImage(imgref)
     //        var bitrep = NSBitmapImageRep(CGImage: newimg)
     //        var nsimg = NSImage()
     //        nsimg.addRepresentation(bitrep)
     
     
     CGContextRef ctx = CGBitmapContextCreate(rawData,
                                     CGImageGetWidth( cgimg ),
                                     CGImageGetHeight( cgimg ),
                                     8,
                                     CGImageGetBytesPerRow( cgimg ),
                                     CGImageGetColorSpace( cgimg ),
                                            (CGBitmapInfo) kCGImageAlphaPremultipliedFirst);
    
     cgimg = CGBitmapContextCreateImage (ctx);
    
    NSBitmapImageRep *bitrep = [[NSBitmapImageRep alloc] initWithCGImage:cgimg];
    NSImage *nsimg = [[NSImage alloc] init];
    [nsimg addRepresentation:bitrep];
    
     
    _view.image = nsimg;
   
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
