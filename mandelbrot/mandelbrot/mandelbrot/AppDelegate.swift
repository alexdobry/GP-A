//
//  AppDelegate.swift
//  mandelbrot
//
//  Created by Patrick Englert on 26.11.14.
//  Copyright (c) 2014 Patrick Englert. All rights reserved.
//

import Cocoa
import AppKit
import QuartzCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    @IBOutlet weak var imgview: NSImageCell!

    func applicationDidFinishLaunching(aNotification: NSNotification) {

//        NSGraphicsContext.currentContext()
        
        var cgsize = CGSizeMake(3860, 3860)
        
        
        var img = NSImage(size: NSMakeSize(3860, 3860))
        img.lockFocus()
        var black = NSColor.blackColor()
        black.setFill()
        NSRectFill(NSMakeRect(0, 0, 3860, 3860))
        img.unlockFocus()
        
        imgview.image = img
        
//        var imgData = img.TIFFRepresentation
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
        
        var imgData = img.TIFFRepresentation
        var imgSource: CGImageSource = CGImageSourceCreateWithData(imgData, nil)
        var cgimg: CGImage = CGImageSourceCreateImageAtIndex(imgSource, 0, nil)
        
        var width = CGImageGetWidth(cgimg)
        var height = CGImageGetHeight(cgimg)
        var f_height = Float(height)
        var f_width = Float(width)
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()

//        var rawData = malloc(height * width * 4)
        let rawData = UnsafeMutablePointer<UInt8>.alloc(Int(height * width * 4))
        
        var bytesPerPixel: UInt = 4
        var bytesPerRow = bytesPerPixel * width
        var bitsPerComponent: UInt = 8
        
        var context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace,
            CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue))
        var cg_width = CGFloat(width)
        var cg_height = CGFloat(height)
        CGContextDrawImage(context, CGRectMake(0, 0, cg_width, cg_height), cgimg)
        var bufferindex = 0
        var max_iteration : Int = 1000

        
        var colors:[NSColor] = []

        
        
        for i in 0 ... max_iteration - 1 {
            var cg_i = CGFloat(i)
            var hue: CGFloat = cg_i / 256
            var sat: CGFloat = 1
            var bright: CGFloat = cg_i / (cg_i + 8)
            
            var alpha: CGFloat = 255
            
            colors.append(NSColor(hue: hue, saturation: sat, brightness: bright, alpha: alpha))
        }
        
        
        var start = NSDate()
        //draw stuff

        for px in 1 ... height {
            for py in 1 ... width {
                var y0 : Float = ((Float(px) - (f_width/2.0)) * 4.0 / f_width  / 110) - 0.65  //* complexPlaneWidth + complexPlaneLeftEdgeCoord
                var x0 : Float = ((Float(py) - (f_height/2.0)) * 4.0 / f_height / 110) + 0.35
                
                var x : Float = 0.0
                var y : Float = 0.0
                
                var iteration : Int = 0
                
                
                while ((x * x + y * y <= 4) && iteration < max_iteration) {
                    var xtemp : Float = x * x  - y * y + x0
                    y = 2 * x * y + y0
                    x = xtemp
                    iteration++
                }
                
                
                
                var r: CGFloat
                var g: CGFloat
                var b: CGFloat
                
                
                if iteration < max_iteration {
                    
                
                    var u_r = UnsafeMutablePointer<CGFloat>.alloc(1)
                    var u_g = UnsafeMutablePointer<CGFloat>.alloc(1)
                    var u_b = UnsafeMutablePointer<CGFloat>.alloc(1)
                    var u_a = UnsafeMutablePointer<CGFloat>.alloc(1)
                    colors[iteration].getRed(u_r, green: u_g, blue: u_b, alpha: u_a)
                    
                    
//                    r = colors[iteration].redComponent
//                    g = colors[iteration].greenComponent
//                    b = colors[iteration].blackComponent
                    
                    rawData[bufferindex] = UInt8(u_r[0] * 255)
                    rawData[bufferindex + 1] = UInt8(u_g[0] * 255)
                    rawData[bufferindex + 2] = UInt8(u_b[0] * 255)
                    
                } else {
                    rawData[bufferindex] = 0
                    rawData[bufferindex + 1] = 0
                    rawData[bufferindex + 2] = 0
                }
                //println("Writing \(px) \(py) \(bufferindex)")

                bufferindex += 4
                
            }
            
           
        }
        var end = NSDate()
         println(end.timeIntervalSinceDate(start))
        //write new img
//        var newimg : CGImage = CGBitmapContextCreateImage(imgref)
//        var bitrep = NSBitmapImageRep(CGImage: newimg)
//        var nsimg = NSImage()
//        nsimg.addRepresentation(bitrep)
        
        
        var ctx = CGBitmapContextCreate(rawData,
            CGImageGetWidth( cgimg ),
            CGImageGetHeight( cgimg ),
            8,
            CGImageGetBytesPerRow( cgimg ),
            CGImageGetColorSpace( cgimg ),
            CGBitmapInfo(CGImageAlphaInfo.PremultipliedLast.rawValue) )
        
        cgimg = CGBitmapContextCreateImage (ctx);
        var bitrep = NSBitmapImageRep(CGImage: cgimg)
        var nsimg = NSImage()
        nsimg.addRepresentation(bitrep)
        
        
        imgview.image = nsimg
//        var dest =
//        
//        var destination = CGImageDestinationCreateWithURL("/test.png", type: kUTTypePNG, 1, nil)
//        
//        CGImageDestinationAddImage(d, cgimg, nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

//getColourFromInt(Math.floor(Math.random() * 16*16*16*16*16*16))
}

