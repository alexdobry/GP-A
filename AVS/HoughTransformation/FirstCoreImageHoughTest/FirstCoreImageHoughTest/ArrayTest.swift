//
//  ArrayTest.swift
//  FirstCoreImageHoughTest
//
//  Created by Markus Müller on 12.11.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Foundation
/*
Untersuchung langsamer Array Zugriffe, insb. für zweidim. Arrays
*/
func testArray() {
// Array für lineare Hough Transformation
    //var array = [[Int]](count: 180, repeatedValue: [Int](count: 1000, repeatedValue: 6));
//    var array = [Int](count: 180*1000, repeatedValue: 0);
//    println("started");
//    for (var x = 0; x < 1000000; x++) {
//        array[(x%180)*1000+x%1000]++;
//    }
//    println("finished");
    
    
// Array für circle hough Transform
    var array = [Int](count: 1600*1200*40, repeatedValue: 0);
    var start = NSDate();
    for (var i = 0; i < 72000*16000; i++) {
        array[(i%1600)*1200+i%40] = i; // schreibender Zugriff (10.6 sekunden)
        //var x = array[(i%1600)*1200+i%40]; // lesender Zugriff (7.4 sekunden)
        //array[(i%1600)*1200+i%40]++; // lesender und schreibender Zugriff (10.8 sekunden)
    }
    var end = NSDate();
    println("ArrayOperations finished after \(end.timeIntervalSinceDate(start))");
}