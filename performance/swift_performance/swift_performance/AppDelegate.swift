//
//  AppDelegate.swift
//  swift_performance
//
//  Created by Patrick Englert on 19.11.14.
//  Copyright (c) 2014 Patrick Englert. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let times = 5
//        mappedTwoDimensionalArray(times)
//        dictArrays(times)
        floats(times)
        arrayAccessing(times)
        twoDimArray(times)
       
        

    
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func  mappedTwoDimensionalArray(times: Int) {
        if (times == 0) {
            return
        }
        

        var arr = [Int](count: 180000, repeatedValue: 1)
        
        var start = NSDate()
        for x in 0...1000000-1 {
            arr[x%180 * 1000 + x%1000]++
        }
        
        var end = NSDate()
        var interval: Double = end.timeIntervalSinceDate(start)
        
        println("One-Dimensional Array with mapped 2nd Dimension: \(interval)")
        mappedTwoDimensionalArray(times - 1)

    }
    
    func dictArrays (times: Int) {
        if (times == 0) {
            return
        }
        
        let n: Int = 10000000
        
        var dict = [Int: [Int]]()
        
        for i in 0...180-1 {
            dict[i] = [Int](count: 1000, repeatedValue: 2)
        }
        
        
        var start = NSDate()
        for x in 0...1000000-1 {
            var i = x%180
            var arr = dict.removeValueForKey(i)
            arr![x%1000]++
            dict.updateValue(arr!, forKey: i)
            
        }

        
        var end = NSDate()
        var interval: Double = end.timeIntervalSinceDate(start)
        
        println("Dictionary with arrays: \(interval)")
        dictArrays(times - 1)
    }

    func floats(times: Int) {
        if (times == 0) {
          return
        }
        
        let n: Int = 10000000
        var x: Float = 0.999999
        var a: Float = 1.0
        var start = NSDate()
        for i in 0...n-1 {
            a = a * x
        }
        
        var end = NSDate()
        var interval: Double = end.timeIntervalSinceDate(start)
        
        println("Multiplying floats: \(interval) last float: \(a)")
        floats(times - 1)
    }
    
    
    func arrayAccessing(times: Int) {
        if (times == 0) {
            return
        }
        let n: Int = 10000
        var x = [Int](count: n, repeatedValue: 1)
        var start = NSDate()
for i in 0...n-1 {
    for j in 0...n-1 {
        x[i] = x[j]++
    }
}
        
        var end = NSDate()
        var interval: Double = end.timeIntervalSinceDate(start)
        
        println("Accessing array: \(interval)")
        arrayAccessing(times - 1)
    }
    
    func twoDimArray (times: Int) {
        if (times == 0) {
            return
        }
        var start2 = NSDate()
        
        var arr = [[Int]](count: 180, repeatedValue: [Int](count: 1000, repeatedValue: 2))
        for x in 0...1000000-1 {
            arr[x%180][x%1000]++
        }
        
        
        var end2 = NSDate()
        var interval2: Double = end2.timeIntervalSinceDate(start2)
        
        println("Two-Dimensional array: \(interval2)")
        twoDimArray(times - 1)
    }

}

