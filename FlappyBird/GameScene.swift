//
//  GameScene.swift
//  Flappy Bird
//
//  Created by Rob Percival on 22/08/2014.
//  Copyright (c) 2014 Appfish. All rights reserved.
///

import SpriteKit
import AVFoundation

var highScore = 0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    var highScoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    
    var audioPlayer: AVAudioPlayer?
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var labelHolder = SKSpriteNode()
    
    let birdGroup:UInt32 = 1
    let objectGroup:UInt32 = 2
    let gapGroup:UInt32 = 0 << 3
    
    var gameOver = 0
    
    var movingObjects = SKNode()
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        self.addChild(movingObjects)
        
        makeBackground()
        
        self.addChild(labelHolder)
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 25
        scoreLabel.text = "Score: 0"
        scoreLabel.position = CGPoint(x: self.frame.midX - 115, y: self.frame.size.height - 70)
        scoreLabel.zPosition = 0
        self.addChild(scoreLabel)
        
        highScoreLabel.fontName = "Helvetica"
        highScoreLabel.fontSize = 25
        highScoreLabel.text = "High: \(highScore)"
        highScoreLabel.position = CGPoint(x: self.frame.midX + 105, y: self.frame.size.height - 70)
        highScoreLabel.zPosition = 0
        self.addChild(highScoreLabel)
        
        let birdTexture = SKTexture(imageNamed: "img/flappy1.png")
        let birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        
        let animation = SKAction.animate(with: [birdTexture, birdTexture2], timePerFrame: 0.1)
        let makeBirdFlap = SKAction.repeatForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture)
        bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        print("Bird Size: \(bird)")
        bird.scale(to: CGSize(width: 73, height: 50))
        bird.run(makeBirdFlap)
        
        //bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        bird.physicsBody?.isDynamic = true
        bird.physicsBody?.allowsRotation = false
        bird.physicsBody?.categoryBitMask = birdGroup
        bird.physicsBody?.contactTestBitMask = objectGroup
        bird.physicsBody?.collisionBitMask = gapGroup
        
        
        bird.zPosition = 10
        scoreLabel.zPosition = 10
        highScoreLabel.zPosition = 10
        gameOverLabel.zPosition = 10
        
        self.addChild(bird)
        
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width, height: 1))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup
        self.addChild(ground)
        
        if score < 5 {
            
          _ = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
            
          } else if score >= 5 && score < 10 {
        
             _ = Timer.scheduledTimer(timeInterval: 1.8, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
        
            } else if score >= 10 && score < 15 {
            
              _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
            
              } else if score >= 15 && score < 20 {
            
                _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
            
              } else {
            
                  _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene.makePipes), userInfo: nil, repeats: true)
        }


    }
    
    
    func makeBackground() {
        
        
        let bgTexture = SKTexture(imageNamed: "img/bg.png")
        
        
        let movebg = SKAction.moveBy(x: -bgTexture.size().width, y: 0, duration: 9)
        let replacebg = SKAction.moveBy(x: bgTexture.size().width, y: 0, duration: 0)
        let movebgForever = SKAction.repeatForever(SKAction.sequence([movebg, replacebg]))
        
        for i in (0 ..< 3) {
            
            if i == 0 {
            
            bg = SKSpriteNode(texture: bgTexture)
            //bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: self.frame.midY)
            bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * 0, y: self.frame.midY)
            bg.size.height = self.frame.height
            
            
            //bg.run(movebgForever)
            
            
            //movingObjects.addChild(bg)
                
            } else {
                
                if i == 1 {
                    
                    bg = SKSpriteNode(texture: bgTexture)
                    //bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: self.frame.midY)
                    bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * 1, y: self.frame.midY)
                    bg.size.height = self.frame.height
                    
                    
                    //bg.run(movebgForever)
                    
                    
                    //movingObjects.addChild(bg)
                
                
                } else {
                    
                    if i == 2 {
                        
                        bg = SKSpriteNode(texture: bgTexture)
                        //bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * i, y: self.frame.midY)
                        bg.position = CGPoint(x: bgTexture.size().width/2 + bgTexture.size().width * 2, y: self.frame.midY)
                        bg.size.height = self.frame.height
                        
                        
                        
                }
                    
                    
            
        }
        
        
    }
            bg.run(movebgForever)
            
            
            movingObjects.addChild(bg)
            

            
        }
        
    }
    
    @objc func makePipes() {
        
        if (gameOver == 0) {
            
            let gapHeight = bird.size.height * 4
            
            let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
            
            let pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
            
            let movePipes = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: TimeInterval(self.frame.size.width / 100))
            
            let removePipes = SKAction.removeFromParent()
            
            let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
            
            
            
            let pipe1Texture = SKTexture(imageNamed: "img/pipe1.png")
            let pipe1 = SKSpriteNode(texture: pipe1Texture)
            print("Pipe1 Size: \(pipe1)")
            pipe1.scale(to: CGSize(width: 118, height: 1664))
            pipe1.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY + pipe1.size.height / 2 + gapHeight / 2 + pipeOffset)
            pipe1.run(moveAndRemovePipes)
            pipe1.physicsBody = SKPhysicsBody(rectangleOf: pipe1.size)
            pipe1.physicsBody?.isDynamic = false
            pipe1.physicsBody?.categoryBitMask = objectGroup
            movingObjects.addChild(pipe1)
            
            let pipe2Texture = SKTexture(imageNamed: "img/pipe2.png")
            let pipe2 = SKSpriteNode(texture: pipe2Texture)
            print("Pipe2 Size: \(pipe2)")
            pipe2.scale(to: CGSize(width: 118, height: 1664))
            pipe2.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY - pipe2.size.height / 2 - gapHeight / 2 + pipeOffset)
            pipe2.run(moveAndRemovePipes)
            pipe2.physicsBody = SKPhysicsBody(rectangleOf: pipe2.size)
            pipe2.physicsBody?.isDynamic = false
            pipe2.physicsBody?.categoryBitMask = objectGroup
            movingObjects.addChild(pipe2)
            
            let gap = SKNode()
            gap.position = CGPoint(x: self.frame.midX + self.frame.size.width, y: self.frame.midY + pipeOffset)
            gap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pipe1.size.width, height: gapHeight))
            gap.run(moveAndRemovePipes)
            gap.physicsBody?.isDynamic = false
            gap.physicsBody?.collisionBitMask = gapGroup
            gap.physicsBody?.categoryBitMask = gapGroup
            gap.physicsBody?.contactTestBitMask = birdGroup
            movingObjects.addChild(gap)
            
            pipe2.zPosition = 0.01
            pipe1.zPosition = 0.01
            
            

            
            
        }
        
    }
    
    func startBackgroundMusic() {
        if let path = Bundle.main.path(forResource: "Bird", ofType: "m4a") {
            //audioPlayer = AVAudioPlayer(contentsOfURL url: NSURL, fileTypeHint utiString: String?) throws
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path), fileTypeHint: "m4a")
            if let player = audioPlayer {
                player.prepareToPlay()
                //player.numberOfLoops = 1
                player.play()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        highScoreLabel.text = "High: \(highScore)"
        
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup {
            
            if score <= 0 {
                
                scoreLabel.text = "Score: 0"
                
                highScoreLabel.text = "High: \(highScore)"
                
            }
            
            score += 1
            
            scoreLabel.text = "Score: \(score)"
            
            //startBackgroundMusic()
            
            if score >= highScore {
                
                highScore = score
                
                highScoreLabel.text = "High: \(highScore)"
                
                let defaults = UserDefaults.standard
                defaults.set("\(highScore)", forKey: defaultsKeys.keyOne)
            }
           
        } else {
            
            if gameOver == 0 {
                
                if score <= 0 {
                    
                    scoreLabel.text = "Score: 0"
                    
                    highScoreLabel.text = "High: \(highScore)"
                    
                    
                } else {
                    
                    score = score - 1
                    scoreLabel.text = "Score: \(score)"
                    
                    if score >= highScore {
                        
                        highScore = score
                        
                        highScoreLabel.text = "High: \(highScore)"
                        
                        let defaults = UserDefaults.standard
                        defaults.set("\(highScore)", forKey: defaultsKeys.keyOne)
                    }
                    
                }
                
               
                gameOver = 1
                
                //startBackgroundMusic()
                
                movingObjects.speed = 0
                
                gameOverLabel.fontName = "Helvetica"
                gameOverLabel.fontSize = 22
                gameOverLabel.text = "Game Over! Tap to play again."
                gameOverLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                labelHolder.addChild(gameOverLabel)
                
            }
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (gameOver == 0) {
            
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50))
            
        } else {
            
            score = 0
            scoreLabel.text = "Score: 0"
            
            highScoreLabel.text = "High: \(highScore)"
            
            movingObjects.removeAllChildren()
            
            makeBackground()
            
            bird.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            labelHolder.removeAllChildren()
            
            gameOver = 0
            
            audioPlayer?.stop()
            
            movingObjects.speed = 1
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        highScoreLabel.text = "High: \(highScore)"
    }
}
