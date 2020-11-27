//
//  MenuScene.swift
//  Somersault
//
//  Created by Айсен Шишигин on 25/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class MenuScene: SimpleScene {
    
    // Sprite nodes
    var playButtonNode = SKSpriteNode()
    var tableNode = SKSpriteNode()
    var itemNode = SKSpriteNode()
    var leftButtonNode = SKSpriteNode()
    var rightButtonNode = SKSpriteNode()
    var flipsTagNode = SKSpriteNode()
    var unlockLabelNode = SKLabelNode()
    
    // variables
    var highScore = 0
    var flipsAmount = 0
    var items = [Item]()
    var selectedItemIndex = 0
    var totalItems = 0

    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        items = ItemController.readItems()
        totalItems = items.count
        
        highScore = UserDefaults.standard.integer(forKey: "localHighScore")
        flipsAmount = UserDefaults.standard.integer(forKey: "flips")
        
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "backgroundMusic.mp3")
        
        setupUI()
    }
    
    func setupUI() {
        // logo node
        let logo = ButtonNode(imageNode: "",
                              position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 100),
                              xScale: 1,
                              yScale: 1)
        self.addChild(logo)
        
        // High score
        let highScoreLabelNode = LabelNode(text: "High score",
                                           fontSize: 20,
                                           position: CGPoint(x: self.frame.midX - 100, y: self.frame.maxY - 165),
                                           fontColor: .black)
        self.addChild(highScoreLabelNode)
        
        // High score amount
        let highScoreAmountLabelNode = LabelNode(text: String(highScore) ,
                                                 fontSize: 70,
                                                 position: CGPoint(x: self.frame.midX - 100, y: self.frame.maxY - 250),
                                                 fontColor: .black)
        self.addChild(highScoreAmountLabelNode)
        
        // total flips label node
        let totalFlipsLabelNode = LabelNode(text: "Amount",
                                            fontSize: 20,
                                            position: CGPoint(x: self.frame.midX + 100, y: self.frame.maxY - 165),
                                            fontColor: .black)
        self.addChild(totalFlipsLabelNode)
        
        // flips amount
        let totalFlipsAmountLabelNode = LabelNode(text: String(flipsAmount) ,
                                                  fontSize: 70,
                                                  position: CGPoint(x: self.frame.midX + 100, y: self.frame.maxY - 250),
                                                  fontColor: .black)
        self.addChild(totalFlipsAmountLabelNode)
        
        // play button
        playButtonNode = ButtonNode(imageNode: "play",
                                    position: CGPoint(x: self.frame.midX, y: self.frame.midY - 15),
                                    xScale: 0.3,
                                    yScale: 0.3)
        self.addChild(playButtonNode)
        
        // Table node
        tableNode = ButtonNode(imageNode: "table",
                               position: CGPoint(x: self.frame.midX, y: self.frame.minY - 30),
                               xScale: 1.3,
                               yScale: 1.3)
        tableNode.zPosition = 3
        self.addChild(tableNode)
        
        // Item node
        selectedItemIndex = ItemController.getSaveItemIndex()
        let selectedItem = items[selectedItemIndex]
        itemNode = SKSpriteNode(imageNamed: selectedItem.Sprite!)
        itemNode.zPosition = 10
        self.addChild(itemNode)
        
        // left button
        leftButtonNode = ButtonNode(imageNode: "left",
                                    position: CGPoint(x: self.frame.midX + leftButtonNode.size.width - 130, y: self.frame.minY - leftButtonNode.size.height + 170),
                                    xScale: 0.3,
                                    yScale: 0.3)
        hideButton(buttonNode: leftButtonNode, state: false)
        self.addChild(leftButtonNode)
        
        // right button
        rightButtonNode = ButtonNode(imageNode: "right",
                                     position: CGPoint(x: self.frame.midX + rightButtonNode.size.width + 130, y: self.frame.minY - rightButtonNode.size.height + 170),
                                     xScale: 0.3,
                                     yScale: 0.3)
        hideButton(buttonNode: rightButtonNode, state: true)
        self.addChild(rightButtonNode)
        
        // Lock node
        flipsTagNode = ButtonNode(imageNode: "lock",
                                  position: CGPoint(x: self.frame.midX + itemNode.size.width * 0.25, y: self.frame.minY + itemNode.size.height / 2 + 100),
                                  xScale: 0.25 ,
                                  yScale: 0.25)
        flipsTagNode.zPosition = 25
        flipsTagNode.zRotation = 0.3
        self.addChild(flipsTagNode)
        
        // Unlock label
        unlockLabelNode = LabelNode(text: "0", fontSize: 80, position: CGPoint(x: 0, y: -unlockLabelNode.frame.size.height + 25), fontColor: .black)
        unlockLabelNode.zPosition = 30
        unlockLabelNode.zRotation = 0.78
        flipsTagNode.addChild(unlockLabelNode)
        
        // update selected item
        updateSelectedItem(selectedItem)
        
        pulseLockNode(flipsTagNode)
    }
    
    func hideButton(buttonNode: SKSpriteNode, state: Bool) {
        if !state {
            buttonNode.isHidden = true
        } else {
            buttonNode.isHidden = false
        }
    }
    
    func updateSelectedItem (_ item: Item) {
        
        // update to the selected item
        let unlockFlips = Int(truncating: item.MinFlips!) - highScore
        let unlocked = unlockFlips <= 0
        
        flipsTagNode.isHidden = unlocked
        unlockLabelNode.isHidden = unlocked
        
        itemNode.texture = SKTexture(imageNamed: item.Sprite!)
        
        itemNode.size = CGSize(width: itemNode.texture!.size().width * CGFloat(item.XScale!.floatValue),
                               height: itemNode.texture!.size().height * CGFloat(item.YScale!.floatValue))
        
        itemNode.position = CGPoint(x: self.frame.midX,
                                    y: self.frame.minY + itemNode.size.height / 2 + 109)
        
        flipsTagNode.position = CGPoint(x: self.frame.midX + itemNode.size.width * 0.25 + 20,
                                        y: self.frame.minY + itemNode.size.height / 2 + 130)
        unlockLabelNode.text = "\(item.MinFlips!.intValue)"
        unlockLabelNode.position = CGPoint(x: unlockLabelNode.frame.size.height + 85,
                                           y: -unlockLabelNode.frame.size.height - 10)
        
        updateArrowsState()
        
    }
    
    func updateArrowsState() {
        hideButton(buttonNode: leftButtonNode,
                   state: Bool(truncating: selectedItemIndex as NSNumber))
        hideButton(buttonNode: rightButtonNode,
                   state: selectedItemIndex != totalItems - 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            // play button is pressed
            if playButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                startGame()
            }
            
            if leftButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let itemIndex = selectedItemIndex - 1
                if itemIndex >= 0 {
                    updateByIndex(itemIndex)
                }
            }
            
            if rightButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let nextIndex = selectedItemIndex + 1
                if nextIndex < totalItems {
                    updateByIndex(nextIndex)
                }
            }
        }
    }
    
    func updateByIndex(_ index: Int) {
        let item = items[index]
        selectedItemIndex = index
        updateSelectedItem(item)
        ItemController.saveSelectedItem(selectedItemIndex)
    }
    
    func pulseLockNode(_ node: SKSpriteNode) {
        let scaleDown = SKAction.scale(to: 0.178, duration: 0.5)
        let scaleUp = SKAction.scale(to: 0.13, duration: 0.5)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        
        node.run(SKAction.repeatForever(sequence))
    }

    func startGame () {
        let userData: NSMutableDictionary = ["item" : items[selectedItemIndex]]
       
        changeToSceneBy(nameScene: "GameScene", userData: userData)
    }
}
 
