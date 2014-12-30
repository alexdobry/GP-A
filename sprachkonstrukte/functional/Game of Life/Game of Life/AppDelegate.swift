//
//  AppDelegate.swift
//  Game of Life
//
//  Created by pascal on 11.12.14.
//  Copyright (c) 2014 pixelskull. All rights reserved.
//


import Cocoa
import SpriteKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            let skView = self.skView
            skView.showsFPS = true
            skView.showsNodeCount = true

            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill

            skView.presentScene(scene)
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }

}
