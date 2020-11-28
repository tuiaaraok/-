//
//  GameScene.swift
//  Somersault
//
//  Created by Айсен Шишигин on 25/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class GameScene: SimpleScene {
    
    var scoreLabelNode = SKLabelNode()
    var highScoreLabelNode = SKLabelNode()
    var backButtonNode = SKSpriteNode()
    var resetButtonNode = SKSpriteNode()
    var tutorialNode = SKSpriteNode()
    var cakeNode = SKSpriteNode()
    var tableNode = SKSpriteNode()
    
    var didSwipe = false
    var start = CGPoint.zero
    var startTime = TimeInterval()
    var currentScore = 0
    
    override func didMove(to view: SKView) {
        
        self.physicsBody?.restitution = 0
        self.backgroundColor = uiBackgroundColor
        
        setupUINodes()
        setupGameNodes()
    }
    
    func setupUINodes() {
        scoreLabelNode = LabelNode(text: "0",
                                   fontSize: 140,
                                   position: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                   fontColor: .black)
        scoreLabelNode.zPosition = -1
        self.addChild(scoreLabelNode)
        
        // High score label node
        highScoreLabelNode = LabelNode(text: "score",
                                       fontSize: 32,
                                       position: CGPoint(x: self.frame.midX, y: self.frame.midY - 40),
                                       fontColor: .black)
        highScoreLabelNode.isHidden = true
        self.addChild(highScoreLabelNode)
        
        // back button
        backButtonNode = ButtonNode(imageNode: "left",
                                    position: CGPoint(x: self.frame.minX + backButtonNode.size.width + 30, y: self.frame.maxY - backButtonNode.size.height - 40),
                                    xScale: 0.3,
                                    yScale: 0.3)
        self.addChild(backButtonNode)
        
        // reset button
        resetButtonNode = ButtonNode(imageNode: "reset",
                                     position: CGPoint(x: self.frame.maxX - backButtonNode.size.width - 15, y: self.frame.maxY - resetButtonNode.size.height - 40),
                                     xScale: 0.09,
                                     yScale: 0.09)
        
        self.addChild(resetButtonNode)
        
        // tutorial button
        let tutorialFinished = UserDefaults.standard.bool(forKey: "tutorialFinushed")
        tutorialNode = ButtonNode(imageNode: "",
                                  position: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                  xScale: 0.55,
                                  yScale: 0.55)
        tutorialNode.zPosition = 5
        tutorialNode.isHidden = tutorialFinished
//        self.addChild(tutorialNode)
    }
    
    func setupGameNodes() {
        // table node
        
//        let tableNode = SKSpriteNode(imageNamed: "table")
//        tableNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tableNode.size.width - 40, height: tableNode.size.height - 30))
//        tableNode.physicsBody?.affectedByGravity = false
//        tableNode.physicsBody?.isDynamic = false
//        tableNode.physicsBody?.restitution = 0
//        tableNode.xScale = 1.3
//        tableNode.yScale = 1.3
        
        let selectedTable = self.userData?.object(forKey: "table")
        tableNode = TableNode(selectedTable as! Table)
        tableNode.position = CGPoint(x: self.frame.midX, y: self.frame.minY - 30)
        self.addChild(tableNode)
        
        let selectedCake = self.userData?.object(forKey: "cake")
        cakeNode = CakeNode(selectedCake as! Cake)
        cakeNode.position = CGPoint(x: self.frame.midX,
                                    y: self.frame.minY + cakeNode.size.height / 2 + 50)

        self.addChild(cakeNode)
        self.resetCake()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // start recording touches
        if touches.count > 1 {
            return
        }
        
        let touch = touches.first
        let location = touch!.location(in: self)
        
        start = location
        startTime = touch!.timestamp
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if backButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                changeToSceneBy(nameScene: "MenuScene", userData: NSMutableDictionary.init())
            }
            
            if resetButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                failedFlip()
            }
            if tutorialNode.contains(location) {
                tutorialNode.isHidden = false
                UserDefaults.standard.set(true, forKey: "tutorialFinished")
                UserDefaults.standard.synchronize()
            }
        }
        
        if !didSwipe {
            let touch = touches.first
            let location = touch?.location(in: self)
            
            let x = ceil(location!.x - start.x)
            let y = ceil(location!.y - start.y)
            
            let distance = sqrt(x*x + y*y)
            
            let time = CGFloat(touch!.timestamp - startTime)
            
            if distance >= gameSwipeMinDistance && y > 0 {
                let speed = distance / time
                
                if speed >= gameSwipeMinSpeed {
                    cakeNode.physicsBody?.angularVelocity = gameAngularVelocity
                    cakeNode.physicsBody?.applyImpulse(CGVector(dx: 0,
                                                                dy: distance * CGFloat(1.75)))
                    didSwipe = true
                }
            }
        }
    }
    
    func failedFlip() {
        SKTAudio.sharedInstance().playSoundEffect(filename: "fail.mp3")
        currentScore = 0
        updateScore()
        resetCake()
    }
    
    func resetCake() {
        SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
        cakeNode.position = CGPoint(x: self.frame.midX,
                                    y: self.frame.minY + cakeNode.size.height / 2 + 50)
        cakeNode.physicsBody?.angularVelocity = 0
        cakeNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        cakeNode.speed = 0
        cakeNode.zRotation = 0
        didSwipe = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        checkIfSuccessfulFlip()
    }
    
    func checkIfSuccessfulFlip() {
       if (cakeNode.position.x <= 0 || cakeNode.position.x >= self.frame.size.width || cakeNode.position.y <= 0) {
            self.failedFlip()
        }
             
        if didSwipe && cakeNode.physicsBody!.isResting {
            let itemRotation = abs(Float(cakeNode.zRotation))
                 
            if itemRotation > 0 && itemRotation < 0.05 {
                self.successFlip()
            } else {
                self.failedFlip()
            }
        }
    }
    
    func successFlip() {
        SKTAudio.sharedInstance().playSoundEffect(filename: "win.mp3")
        updateFlips()
        currentScore += 1
        updateScore()
        resetCake()
    }
    
    func updateScore() {
        scoreLabelNode.text = "\(currentScore)"
        
        let localHighScore = UserDefaults.standard.integer(forKey: "localHighScore")
        
        if currentScore > localHighScore {
            highScoreLabelNode.isHidden = false
            let fadeAction = SKAction.fadeAlpha(to: 0, duration: 1.0)
            highScoreLabelNode.run(fadeAction) {
                self.highScoreLabelNode.isHidden = true
            }
            
            UserDefaults.standard.set(currentScore, forKey: "localHighScore")
            UserDefaults.standard.synchronize()
            
        }
    }
    
    func updateFlips() {
        var flips = UserDefaults.standard.integer(forKey: "flips")
        
        flips += 1
        UserDefaults.standard.set(flips, forKey: "flips")
        UserDefaults.standard.synchronize()
    }
}
