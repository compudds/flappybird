//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Eric Cook on 1/28/15.
//  Copyright (c) 2015 Better Search, LLC. All rights reserved.
///

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            
            //let error = NSError()
            
            //let archiver = try! NSKeyedUnarchiver(forReadingFrom: sceneData)
            
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            //let archiver = NSKeyedUnarchiver(initForReadingFromData: sceneData, error: error)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
            
            let defaults = UserDefaults.standard
            if let stringOne = defaults.string(forKey: defaultsKeys.keyOne) {
                
                print("High Score: \(stringOne)") // Some String Value
                
                highScore = Int(stringOne)!
               
            }
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.allButUpsideDown
        } else {
            return UIInterfaceOrientationMask.all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}

struct defaultsKeys {
    static let keyOne = "highScoreStringKey"
    static let keyTwo = "secondStringKey"
}

