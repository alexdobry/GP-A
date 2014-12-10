//
//  HoughTransformation.swift
//  FirstCoreImageHoughTest
//
//  Created by Markus Müller on 12.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import QuartzCore

private var pi = 3.14159265359;

func houghLineTransform() -> Void {
    // Create CIImage from URL
    let imgUrl = NSURL(fileURLWithPath: "/Users/mmueller/Documents/GP-A/AVS/HoughTransformation/coins.png");
    let outUrl = NSURL(fileURLWithPath: "/Users/mmueller/Documents/GP-A/AVS/HoughTransformation/coinEdgesOut.png");
    let img = CIImage(contentsOfURL: imgUrl);
    
    
    println(img);
    
    // Create and define Filter for Grey
    //        var filter = CIFilter(name: "CIColorControls")
    //        filter.setValue(img, forKey: kCIInputImageKey)
    //        filter.setValue(0, forKey: kCIInputBrightnessKey)
    //        filter.setValue(1.1, forKey: kCIInputContrastKey)
    //        filter.setValue(0, forKey: kCIInputSaturationKey)
    //
    //        var filter2 = CIFilter(name: "CIExposureAdjust");
    //        filter2.setValue(filter.outputImage, forKey: kCIInputImageKey);
    //        filter2.setValue(0.7, forKey: kCIInputEVKey);
    
    //        // GaussianBlur filter
    //        var gaussFilter = CIFilter(name: "CIGaussianBlur");
    //        gaussFilter.setValue(filter2.outputImage, forKey: kCIInputImageKey);
    //        gaussFilter.setValue(11, forKey: kCIInputRadiusKey);
    
    var gaussFilter = CIFilter(name:"CIGaussianBlur");
    gaussFilter.setValue(img, forKey: kCIInputImageKey);
    gaussFilter.setValue(2, forKey: kCIInputRadiusKey);
    
    
    // Edge Detection filter
    var edgeFilter = CIFilter(name: "CILineOverlay");
    edgeFilter.setValue(gaussFilter.outputImage, forKey: kCIInputImageKey);
    edgeFilter.setValue(0.07, forKey: "inputNRNoiseLevel");
    edgeFilter.setValue(0.71, forKey: "inputNRSharpness");
    edgeFilter.setValue(0.05, forKey: "inputEdgeIntensity");
    edgeFilter.setValue(0.06, forKey: "inputThreshold");
    edgeFilter.setValue(50, forKey: "inputContrast");
    
    // Create and define Context to filter and output image
    var context = CIContext();
    var output = context.createCGImage(edgeFilter.outputImage, fromRect: img.extent());
    
    // Create DrawingContext with "output"
    var height:UInt = CGImageGetHeight(output);
    var width:UInt = CGImageGetWidth(output);
    
    var cgContext = CGBitmapContextCreate(nil, width, height, CGImageGetBitsPerComponent(output), CGImageGetBytesPerRow(output), CGImageGetColorSpace(output), CGImageGetBitmapInfo(output));
    CGContextSetLineWidth(cgContext, 1);
    var components:Array<CGFloat> = [0.0, 0.0, 1.0, 1.0];
    var colorspace = CGImageGetColorSpace(output);
    var color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(cgContext, color);
    CGContextSetAlpha(cgContext, 0.8);
    
    CGContextDrawImage(cgContext, img.extent(), output);
    
    
    // Hough Transformation
    var numPixel = height*width;
    
    var data = CGDataProviderCopyData(CGImageGetDataProvider(output));
    var pixels = CFDataGetBytePtr(data);
    
    // create 180*maxrho array
    var maxrho:Int = Int(sqrt(pow(Double(height), 2)+pow(Double(width), 2)));
    //var accumulator = [[Int]](count: 180, repeatedValue: [Int](count: 2*maxrho, repeatedValue: 0));
    var accumulator = [Int](count: 180*2*maxrho, repeatedValue: 0);
    
    // Compute Cosinus and Sinus values for all pos. thetas
    var cosVal = [Double](count:180, repeatedValue: 0);
    var sinVal = [Double](count:180, repeatedValue: 0);
    for (var thetaIndex = 0; thetaIndex < 180; thetaIndex++) {
        var theta = Double(thetaIndex)*pi/180 - pi/2;
        cosVal[thetaIndex] = cos(theta);
        sinVal[thetaIndex] = sin(theta);
    }
    for (var counter:UInt = UInt(0); counter < numPixel; counter++) {
        var notNull = false;
        for (var c2 = 0; c2 < 4; c2++) {
            if (pixels.memory > 0) {
                notNull = true;
            }
            pixels = pixels.successor();
        }
        // ignore pixels at the edge of the image
        if (counter < width || counter > numPixel-width || counter%width == 0 || (counter+1)%width == 0) {
            continue;
        }
        if (notNull) {
            var x = Double(counter%width);
            var y = Double(height-Int(counter/width));
            //println("Pixel at \(x), \(y)");
            for (var thetaIndex = 0; thetaIndex < 180; thetaIndex++) {
                var rho = x * cosVal[thetaIndex] + y * sinVal[thetaIndex];
                //accumulator[thetaIndex][Int(rho)+maxrho]++;
                accumulator[thetaIndex*2*maxrho+Int(rho)+maxrho]++;
            }
        }
    }
    
    // Maximum bestimmen
    var maxVal = 0;
    var maxPos:(theta:Double,rho:Int)!;
    for (var i = 0; i < 180; i++) {
        for (var j = 0; j < 2*maxrho; j++) {
//            if (accumulator[i][j] > maxVal) {
//                maxVal = accumulator[i][j];
//                maxPos = (theta:(Double(i)*pi/180)-pi/2, rho:j-maxrho);
//            }
            if (accumulator[i*2*maxrho+j] > maxVal) {
                maxVal = accumulator[i*2*maxrho+j];
                maxPos = (theta:(Double(i)*pi/180)-pi/2, rho:j-maxrho);
            }
        }
    }
    
    // Punkte ermitteln
    var p1:(x:Int,y:Int);
    var p2:(x:Int,y:Int);
    if (maxPos.theta == 0) {
        // theta = 0, also Linie parallel zur y-Achse
        // y = 0
        p1 = (x:Int(Double(maxPos.rho)/cos(maxPos.theta)), y:0);
        // y = height
        p2 = (x:Int((Double(maxPos.rho) - Double(height)*sin(maxPos.theta))/cos(maxPos.theta)), y:Int(height));
    } else {
        // theta = pi/2 oder theta = -pi/2, also Linie parallel zur x-Achse
        // oder irgendwie anders (Normalfall)
        // x = 0
        p1 = (x:0, y:Int(Double(maxPos.rho)/sin(maxPos.theta)));
        // x = width
        p2 = (x:Int(width), y:Int((Double(maxPos.rho) - Double(width)*cos(maxPos.theta))/sin(maxPos.theta)));
    }
    
    // Zeichnen
    CGContextMoveToPoint(cgContext, CGFloat(p1.x), CGFloat(p1.y));
    CGContextAddLineToPoint(cgContext, CGFloat(p2.x), CGFloat(p2.y));
    CGContextStrokePath(cgContext);
    
    var testImgout = CGBitmapContextCreateImage(cgContext);
    
    let destination = CGImageDestinationCreateWithURL(outUrl, kUTTypePNG, 1, nil);
    CGImageDestinationAddImage(destination, testImgout, nil);
    
    if (!CGImageDestinationFinalize(destination)) {
        println("Failed to write image to \(outUrl)");
    }
}

//var (height, width, maxR, minR): (Int, Int, Int, Int);

func houghCircleTransform() -> Void {
        // Create CIImage from URL
        let imgUrl = NSURL(fileURLWithPath: "/Users/mmueller/Documents/GP-A/AVS/HoughTransformation/coins.png");
        let outUrl = NSURL(fileURLWithPath: "/Users/mmueller/Documents/GP-A/AVS/HoughTransformation/outCoins2.png");
        let img = CIImage(contentsOfURL: imgUrl);
        
        
        //println(img);
        
        // Create and define Filter for Grey
        //        var filter = CIFilter(name: "CIColorControls")
        //        filter.setValue(img, forKey: kCIInputImageKey)
        //        filter.setValue(0, forKey: kCIInputBrightnessKey)
        //        filter.setValue(1.1, forKey: kCIInputContrastKey)
        //        filter.setValue(0, forKey: kCIInputSaturationKey)
        //
        //        var filter2 = CIFilter(name: "CIExposureAdjust");
        //        filter2.setValue(filter.outputImage, forKey: kCIInputImageKey);
        //        filter2.setValue(0.7, forKey: kCIInputEVKey);
        
        //        // GaussianBlur filter
        //        var gaussFilter = CIFilter(name: "CIGaussianBlur");
        //        gaussFilter.setValue(filter2.outputImage, forKey: kCIInputImageKey);
        //        gaussFilter.setValue(11, forKey: kCIInputRadiusKey);
    
    var startGauss = NSDate();
        var gaussFilter = CIFilter(name:"CIGaussianBlur");
        gaussFilter.setValue(img, forKey: kCIInputImageKey);
        gaussFilter.setValue(1, forKey: kCIInputRadiusKey);
    var endGauss = NSDate();
    println("GaussFilter finished after \(endGauss.timeIntervalSinceDate(startGauss))");
        
        // Edge Detection filter
    var startEdge = NSDate();
        var edgeFilter = CIFilter(name: "CILineOverlay");
        edgeFilter.setValue(gaussFilter.outputImage, forKey: kCIInputImageKey);
        edgeFilter.setValue(0.07, forKey: "inputNRNoiseLevel");
        edgeFilter.setValue(0.71, forKey: "inputNRSharpness");
        edgeFilter.setValue(0.05, forKey: "inputEdgeIntensity");
        edgeFilter.setValue(0.06, forKey: "inputThreshold");
        edgeFilter.setValue(50, forKey: "inputContrast");
    var endEdge = NSDate();
    println("EdgeFilter finished after \(endEdge.timeIntervalSinceDate(startEdge))");
    
    
        // Create and define Context to filter and output image
        var context = CIContext();
        var output = context.createCGImage(edgeFilter.outputImage, fromRect: img.extent());
        
        // Create DrawingContext with "output"
        var height:Int = Int(CGImageGetHeight(output));
        var width:Int = Int(CGImageGetWidth(output));
        
        var cgContext = CGBitmapContextCreate(nil, UInt(width), UInt(height), CGImageGetBitsPerComponent(output), CGImageGetBytesPerRow(output), CGImageGetColorSpace(output), CGImageGetBitmapInfo(output));
        CGContextSetLineWidth(cgContext, 1);
        var components:Array<CGFloat> = [0.0, 0.0, 1.0, 1.0];
        var colorspace = CGImageGetColorSpace(output);
        var color = CGColorCreate(colorspace, components);
        CGContextSetStrokeColorWithColor(cgContext, color);
        CGContextSetAlpha(cgContext, 0.8);
        
    CGContextDrawImage(cgContext, img.extent(), output); //context.createCGImage(img, fromRect: img.extent()));
        
    var startTransform = NSDate();
        // Hough Transformation (x-a)^2+(y-b)^2=r^2
        var numPixel = height*width;
        
        var data = CGDataProviderCopyData(CGImageGetDataProvider(output));
        var pixels = CFDataGetBytePtr(data);
    //println(CFDataGetLength(data));
    //println(numPixel);
    //println(CFDataGetLength(data)/CFIndex(numPixel));
    
    // Minimaler und Maximaler Radius des zu erkennenden Kreises
    var minR:Int = 75;
    var maxR:Int = 90;
        
        // create width*height*(maxR-minR) array
        var accumulator = [Int](count: Int(width)*Int(height)*(maxR-minR), repeatedValue: 0);
    var edgePixelCounter = 0;
    
    // Compute Cosinus and Sinus values for all pos. thetas
    var cosVal = [Double](count:180, repeatedValue: 0);
    var sinVal = [Double](count:180, repeatedValue: 0);
    for (var thetaIndex = 0; thetaIndex < 180; thetaIndex++) {
        var theta = Double(thetaIndex)*pi/180 - pi/2;
        cosVal[thetaIndex] = cos(theta);
        sinVal[thetaIndex] = sin(theta);
    }
    
        for (var counter:Int = 0; counter < numPixel; counter++) {
            var white = true;
            var transparent = true;
            // prüfe auf farben (die ersten 3 bytes: RGB) (eine < 255 -> kein weiß)
            for (var c2 = 0; c2 < 3; c2++) {
                if (pixels.memory < 255) {
                    white = false;
                }
                pixels = pixels.successor();
            }
            // und Alpha Kanal > 0 (4. Byte)
            if (pixels.memory > 0) {
                transparent = false;
            }
            pixels = pixels.successor();
            
            //println("\(white) \(transparent)");
            if (!white && !transparent) {
                edgePixelCounter++;
                var x = Double(counter%width);
                var y = Double(height-counter/width);
                // println("Pixel at \(x), \(y)");
//                for (var r = minR; r < maxR; r++) {
//                    // auf x-Achse nur im Rahmen des maximalen Radius
//                    for (var a = Int(x)-maxR >= 0 ? Int(x)-maxR : 0; a < Int(x)+maxR && a < width; a++) {
//                        var inRoot1 = -pow(Double(a), 2) + 2*Double(a)*x;
//                        var inRoot2 = pow(Double(r), 2) - pow(x, 2);
//                        var inRoot = inRoot1 + inRoot2;
//                        if (inRoot >= 0) {
//                            // valid b (no imaginary number)
//                            var b1 = Int(y + sqrt(inRoot));
//                            var b2 = Int(y - sqrt(inRoot));
//                            if (b1 == b2) {
//                                // nur ein Inkrement für den gleichen Wert von b
//                                if (b1 >= 0 && b1 < height) { // TODO: Offset des Indexes einbauen anstatt Kreismittelpunkte nur innerhalb der Bildgrenzen anzunehmen!
//                                    var ind = a*height*(maxR-minR)+b1*(maxR-minR)+r-minR;
//                                    accumulator[ind]++;
//                                }
//                            } else {
//                                // ein Inkrement für jeden der zwei Werte von b (b1 UND b2)
//                                if (b1 >= 0 && b1 < height) {
//                                    var ind = a*height*(maxR-minR)+b1*(maxR-minR)+r-minR;
//                                    accumulator[ind]++;
//                                }
//                                if (b2 >= 0 && b2 < height) {
//                                    var ind = a*height*(maxR-minR)+b2*(maxR-minR)+r-minR;
//                                    accumulator[ind]++;
//                                }
//                            }
//                        }
//                    }
//                }
                
                for (var r = minR; r < maxR; r++) {
                    for (var thetaIndex = 0; thetaIndex < 180; thetaIndex++) {
                        var a = Int(x - Double(r) * cosVal[thetaIndex]);
                        var b = Int(y + Double(r) * sinVal[thetaIndex]);
                        if (a > 0 && b > 0 && a < width && b < height) {
                            var ind = a*height*(maxR-minR)+b*(maxR-minR)+r-minR;
                            accumulator[ind]++;
                        }
                    }
                }
            }
        }
    
        // Maximum bestimmen
        var maxVal = 0;
        var maxPos:(a:Int, b:Int, r:Int)!;
        for (var i = 0; i < Int(width); i++) {
            for (var j = 0; j < Int(height); j++) {
                for (var k = minR; k < maxR; k++) {
                    if (accumulator[i*Int(height)*(maxR-minR)+Int(j)*(maxR-minR)+k-minR] > maxVal) {
                        maxVal = accumulator[i*Int(height)*(maxR-minR)+Int(j)*(maxR-minR)+k-minR];
                        maxPos = (a: i, b: j, r: k);
                    }
                }
            }
        }
    var endTransform = NSDate();
    println("Transform finished after \(endTransform.timeIntervalSinceDate(startTransform))");
    println("Edge Pixel processed: \(edgePixelCounter)");
    println("MaxPos = \(maxPos)");
    
        // Kreis Zeichnen
        CGContextAddEllipseInRect(cgContext, CGRect(x: maxPos.a-maxPos.r, y: maxPos.b-maxPos.r, width: 2*maxPos.r, height: 2*maxPos.r));
        CGContextStrokePath(cgContext);
    
        var testImgout = CGBitmapContextCreateImage(cgContext);
        
        let destination = CGImageDestinationCreateWithURL(outUrl, kUTTypePNG, 1, nil);
        CGImageDestinationAddImage(destination, testImgout, nil);
        
        if (!CGImageDestinationFinalize(destination)) {
            println("Failed to write image to \(outUrl)");
        }
}

//func arrayIndexOf(x: Int, y: Int, r: Int) -> Int {
//    return x*Int(height)*(maxR-minR)+y*(maxR-minR)+r-minR;
//}


