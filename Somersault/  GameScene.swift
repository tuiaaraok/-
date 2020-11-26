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
    var itemNode = SKSpriteNode()
    
    var didSwipe = false
    var start = CGPoint.zero
    var startTime = TimeInterval()
    
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
        let tableNode = SKSpriteNode(imageNamed: "table")
        tableNode.physicsBody = SKPhysicsBody(rectangleOf: (tableNode.texture?.size())!)
        tableNode.physicsBody?.affectedByGravity = false
        tableNode.physicsBody?.isDynamic = false
        tableNode.physicsBody?.restitution = 0
        tableNode.xScale = 1.3
        tableNode.yScale = 1.3
        tableNode.position = CGPoint(x: self.frame.midX, y: self.frame.minY - 30)
        self.addChild(tableNode)
        
        // Item node
        let selectedItem = self.userData?.object(forKey: "item")
       
        itemNode = ItemNode(selectedItem as! Item)
        itemNode.position = CGPoint(x: self.frame.midX,y: self.frame.minY + itemNode.size.height / 2 + 109)
        self.addChild(itemNode)
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
                self.changeToSceneBy(nameScene: "MenuScene", userData: NSMutableDictionary.init())
            }
            
            if resetButtonNode.contains(location) {
                failedFlip()
            }
            if tutorialNode.contains(location) {
                tutorialNode.isHidden = false
                UserDefaults.standard.set(true, forKey: "tutorialFinished")
                UserDefaults.standard.synchronize()
            }
        }
        
        // Item fliping logic
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
                    // add angular velocity and impulse
                    itemNode.physicsBody?.angularVelocity = gameAngularVelocity
                    itemNode.physicsBody?.applyImpulse(CGVector(dx: 0, dy: distance * 1.75))
                    didSwipe = true
                }
            }
        }
        
    }
    
    func failedFlip() {
        self.resetItem()
    }
    
    func resetItem() {
        itemNode.position = CGPoint(x: self.frame.midX,y: self.frame.minY + itemNode.size.height / 2 + 109)
        itemNode.physicsBody?.angularVelocity = 0
        itemNode.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        itemNode.speed = 0
        itemNode.zRotation = 0
        didSwipe = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
