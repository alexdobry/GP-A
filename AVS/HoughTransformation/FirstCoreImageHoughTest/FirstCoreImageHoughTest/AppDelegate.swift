//
//  AppDelegate.swift
//  FirstCoreImageHoughTest
//
//  Created by Markus Müller on 22.10.14.
//  Copyright (c) 2014 Markus Müller. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        var start = NSDate();
        houghLineTransform();
        //houghCircleTransform();
        //testArray();
        var end = NSDate();
        println("Finished after \(end.timeIntervalSinceDate(start))");
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

