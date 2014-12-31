//
//  ViewController.swift
//  FractalGenerator
//
//  Created by Tina Böttger on 12.11.14.
//  Copyright (c) 2014 Tina Böttger. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

   
    @IBOutlet weak var image: NSImageView!

    @IBOutlet weak var pm1TB: NSTextField!
    @IBOutlet weak var pm2TB: NSTextField!
    @IBOutlet weak var pm3TB: NSTextField!
    @IBOutlet weak var loopTB: NSTextField!
    @IBOutlet weak var colorTB: NSTextField!
    @IBOutlet weak var zoomTB: NSTextField!
    
    var (pm1, pm2, pm3, teilfaktor, schleifenzahl, counter, jump): (Float, Float, Float, Float, Int, Float, Float) = (0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0)
    var  (x,y, xx, yy) : (Float, Float, Float, Float) = (0.0,0.0, 0.0,0.0)
   
    
    override func viewDidLoad() { super.viewDidLoad() }

    @IBAction func click(sender: AnyObject) {
        // setup Image
        var size = NSMakeSize(1200,600)
        var img = NSImage(size: size)
        image.image = img
        // setup var´s
        xx = 0
        yy = 0
        x = 0
        y = 0
        
        counter = 0
        pm1 = pm1TB.floatValue
        pm2 = pm2TB.floatValue
        pm3 = pm3TB.floatValue
        schleifenzahl = Int(loopTB.intValue)
        teilfaktor = zoomTB.floatValue
        jump = colorTB.floatValue

        var start = NSDate()
        var red : CGFloat
        var green : CGFloat
        var blue : CGFloat
        var coord1 : CGFloat
        var coord2 : CGFloat

        // lock image
        image.image?.lockFocus()
//        var black = NSColor.blackColor()
//        black.setFill()
//        NSRectFill(NSMakeRect(0, 0, 4000, 4000))
        // draw stuff
        for (var i : Int = 1; i < schleifenzahl ; ++i)
        {
            if (counter > 255) {
                counter = 1
            }
            coord1 = CGFloat(((10 * x)/teilfaktor)+650)
            coord2 = CGFloat(((10 * y)/teilfaktor)+400)

            red = (255 - CGFloat(counter)) / 255
            green = (CGFloat(counter)) / 255
            blue = CGFloat(127 + counter / 2) / 255


//            println("---> red: \(red.description) green: \(green.description) blue: \(blue.description)")

            var fillColor = NSColor(red: red, green: green, blue: blue, alpha: 1)
            fillColor.set()

            NSRectFill(NSMakeRect(coord1, coord2, 1, 1))

            xx = y - (sign(x) * (sqrt(abs(pm2 * x - pm3))))

            if abs(x - xx) < jump {
                counter = counter + 1
            }

            yy = (pm1 - x)
            x = xx
            y = yy
        }
        // take time
        var end = NSDate()
        println(end.timeIntervalSinceDate(start))
        // unlock image
        image.image?.unlockFocus()
    }
    
    func sign(num : Float) -> Float{
            if (x < 0) {
                return 1;
            }
            return 1;
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

