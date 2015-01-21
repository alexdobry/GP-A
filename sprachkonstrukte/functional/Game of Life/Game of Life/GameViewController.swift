//
//  GameViewController.swift
//  Game of Life
//
//  Created by pascal on 14.12.14.
//  Copyright (c) 2014 pixelskull. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file: NSString) -> SKNode? {
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        var sceneData = NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData!)

        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
        archiver.finishDecoding()
        return scene
    }
}

class GameViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true

            skView.ignoresSiblingOrder = true
            scene.scaleMode = .AspectFill

            skView.presentScene(scene)
        }

    }
}
