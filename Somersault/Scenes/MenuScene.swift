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
    var cakeNode = SKSpriteNode()
    var leftCakeButtonNode = SKSpriteNode()
    var rightCakeButtonNode = SKSpriteNode()
    var leftTableButtonNode = SKSpriteNode()
    var rightTableButtonNode = SKSpriteNode()
    var leftBgButtonNode = SKSpriteNode()
    var rightBgButtonNode = SKSpriteNode()
    
    var lockBowForCake = SKSpriteNode()
    var unlockLabelNodeForCake = SKLabelNode()
    var lockBowForTable = SKSpriteNode()
    var unlockLabelNodeForTable = SKLabelNode()
    
    // variables
    var highScore = 0
    var flipsAmount = 0
    var cakes = [Cake]()
    var tables = [Table]()
    var selectedCakeIndex = 0
    var selectedTableIndex = 0
    var totalCakes = 0
    var totalTables = 0

    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        cakes = ItemController.readCakes()
        tables = ItemController.readTables()
       
        totalCakes = cakes.count
        totalTables = tables.count
        
        highScore = UserDefaults.standard.integer(forKey: "localHighScore")
        flipsAmount = UserDefaults.standard.integer(forKey: "flips")
        
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "backgroundMusic.mp3")
        view.ignoresSiblingOrder = false
        setupUI()
    }
    
    func setupUI() {
        
        // High score
        let highScoreLabelNode = LabelNode(text: "High score", fontSize: 40, position: CGPoint(x: self.frame.midX - 100, y: self.frame.maxY - 215), fontColor: .black)
        highScoreLabelNode.zPosition = 1
        self.addChild(highScoreLabelNode)
        
        // High score amount
        let highScoreAmountLabelNode = LabelNode(text: String(highScore) , fontSize: 70, position: CGPoint(x: self.frame.midX - 100, y: self.frame.maxY - 300), fontColor: .black)
        highScoreAmountLabelNode.zPosition = 1
        self.addChild(highScoreAmountLabelNode)
        
        // total flips label node
        let totalFlipsLabelNode = LabelNode(text: "Amount", fontSize: 40, position: CGPoint(x: self.frame.midX + 100, y: self.frame.maxY - 215), fontColor: .black)
        totalFlipsLabelNode.zPosition = 1
        self.addChild(totalFlipsLabelNode)
        
        // flips amount
        let totalFlipsAmountLabelNode = LabelNode(text: String(flipsAmount), fontSize: 70, position: CGPoint(x: self.frame.midX + 100, y: self.frame.maxY - 300), fontColor: .black)
        totalFlipsAmountLabelNode.zPosition = 1
        self.addChild(totalFlipsAmountLabelNode)
        
        // play button
        playButtonNode = ButtonNode(imageNode: "play", position: CGPoint(x: self.frame.midX, y: self.frame.midY - 15), xScale: 1.4, yScale: 1.4)
        self.addChild(playButtonNode)
        
        // Table node
        selectedTableIndex = ItemController.getSaveIndex(key: "SelectedTable")
        let selectedTable = tables[selectedTableIndex]
        tableNode = ButtonNode(imageNode: selectedTable.Sprite!, position: CGPoint(x: self.frame.midX, y: self.frame.minY - 30), xScale: 1.3, yScale: 1.3)
        tableNode.zPosition = 1
        self.addChild(tableNode)
        
        // Cake node
        selectedCakeIndex = ItemController.getSaveIndex(key: "SelectedCake")
        let selectedCake = cakes[selectedCakeIndex]
        cakeNode = SKSpriteNode(imageNamed: selectedCake.Sprite!)
        cakeNode.zPosition = 10
        self.addChild(cakeNode)
        
        // pic node
        let pic = ButtonNode(imageNode: "painting", position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 60), xScale: 1.2, yScale: 1.2)
        pic.zPosition = -1
        self.addChild(pic)
        
        // left cake button
        leftCakeButtonNode = ButtonNode(imageNode: "left", position: CGPoint(x: self.frame.midX + leftCakeButtonNode.size.width - 130, y: self.frame.minY - leftCakeButtonNode.size.height + 170), xScale: 0.3, yScale: 0.3)
        hideButton(buttonNode: leftCakeButtonNode, state: false)
        self.addChild(leftCakeButtonNode)
        
        // right cake button
        rightCakeButtonNode = ButtonNode(imageNode: "right", position: CGPoint(x: self.frame.midX + rightCakeButtonNode.size.width + 130, y: self.frame.minY - rightCakeButtonNode.size.height + 170), xScale: 0.3, yScale: 0.3)
        hideButton(buttonNode: rightCakeButtonNode, state: true)
        self.addChild(rightCakeButtonNode)
        
//        // left bg button
//        leftBgButtonNode = ButtonNode(imageNode: "left", position: CGPoint(x: self.frame.midX + leftBgButtonNode.size.width - 130, y: self.frame.minY - leftBgButtonNode.size.height + 300), xScale: 0.3, yScale: 0.3)
//        hideButton(buttonNode: leftBgButtonNode, state: false)
//        self.addChild(leftBgButtonNode)
//
//        // right bg button
//        rightBgButtonNode = ButtonNode(imageNode: "right", position: CGPoint(x: self.frame.midX + rightBgButtonNode.size.width + 130, y: self.frame.minY - rightBgButtonNode.size.height + 300), xScale: 0.3, yScale: 0.3)
//        hideButton(buttonNode: rightBgButtonNode, state: true)
//        self.addChild(rightBgButtonNode)
        
        // left table button
        leftTableButtonNode = ButtonNode(imageNode: "left", position: CGPoint(x: self.frame.midX + leftTableButtonNode.size.width - 170, y: self.frame.minY - leftTableButtonNode.size.height + 50), xScale: 0.3, yScale: 0.3)
        leftTableButtonNode.zPosition = 2
        hideButton(buttonNode: leftTableButtonNode, state: false)
        self.addChild(leftTableButtonNode)
               
        // right table button
        rightTableButtonNode = ButtonNode(imageNode: "right", position: CGPoint(x: self.frame.midX + rightTableButtonNode.size.width + 170, y: self.frame.minY - rightTableButtonNode.size.height + 50), xScale: 0.3, yScale: 0.3)
        rightTableButtonNode.zPosition = 2
        hideButton(buttonNode: rightTableButtonNode, state: true)
        self.addChild(rightTableButtonNode)
        
        // Lock node for cake
        lockBowForCake = ButtonNode(imageNode: "lock", position: CGPoint(x: self.frame.midX + cakeNode.size.width * 0.25, y: self.frame.minY + cakeNode.size.height / 2 + 100), xScale: 0.25, yScale: 0.25)
        lockBowForCake.zPosition = 25
        lockBowForCake.zRotation = 0.3
        self.addChild(lockBowForCake)
        
        // Lock node for table
        lockBowForTable = ButtonNode(imageNode: "lock", position: CGPoint(x: self.frame.midX + tableNode.size.width * 0.25, y: self.frame.minY + tableNode.size.height / 2 + 100), xScale: 0.25, yScale: 0.25)
        lockBowForTable.zPosition = 25
        lockBowForTable.zRotation = 0.3
        self.addChild(lockBowForTable)
       
        
        // Unlock label for cake
        unlockLabelNodeForCake = LabelNode(text: "0", fontSize: 80, position: CGPoint(x: 0, y: -unlockLabelNodeForCake.frame.size.height + 25), fontColor: .black)
        unlockLabelNodeForCake.zPosition = 30
        unlockLabelNodeForCake.zRotation = 0.78
        lockBowForCake.addChild(unlockLabelNodeForCake)
        
        // Unlock label for table
        unlockLabelNodeForTable = LabelNode(text: "0", fontSize: 80, position: CGPoint(x: 0, y: -unlockLabelNodeForCake.frame.size.height + 25), fontColor: .black)
        unlockLabelNodeForTable.zPosition = 30
        unlockLabelNodeForTable.zRotation = 0.78
        lockBowForTable.addChild(unlockLabelNodeForTable)
        
        // update selected item
        updateSelectedCake(selectedCake)
        updateSelectedTable(selectedTable)
        
        pulseLockNode(lockBowForCake)
        pulseLockNode(lockBowForTable)
        
    }
    
    func hideButton(buttonNode: SKSpriteNode, state: Bool) {
        if !state {
            buttonNode.isHidden = true
        } else {
            buttonNode.isHidden = false
        }
    }
    
    func updateSelectedCake (_ cake: Cake) {
        
        // update to the selected item
        let unlockFlips = Int(truncating: cake.MinFlips!) - highScore
        let unlocked = unlockFlips <= 0
        
        lockBowForCake.isHidden = unlocked
        unlockLabelNodeForCake.isHidden = unlocked
        
        cakeNode.texture = SKTexture(imageNamed: cake.Sprite!)
        
        cakeNode.size = CGSize(width: cakeNode.texture!.size().width * CGFloat(cake.XScale!.floatValue), height: cakeNode.texture!.size().height * CGFloat(cake.YScale!.floatValue))
        
        cakeNode.position = CGPoint(x: self.frame.midX,
                                    y: self.frame.minY + cakeNode.size.height / 2 + 109)
        
        lockBowForCake.position = CGPoint(x: self.frame.midX + cakeNode.size.width * 0.25 + 20,
                                        y: self.frame.minY + cakeNode.size.height / 2 + 130)
        unlockLabelNodeForCake.text = "\(cake.MinFlips!.intValue)"
        unlockLabelNodeForCake.position = CGPoint(x: unlockLabelNodeForCake.frame.size.height + 85,
                                           y: -unlockLabelNodeForCake.frame.size.height - 10)
        
        updateCakeArrowsState()
        
    }
    
    func updateSelectedTable(_ table: Table) {
           
           // update to the selected item
           let unlockFlips = Int(truncating: table.MinFlips!) - highScore
           let unlocked = unlockFlips <= 0
           
           lockBowForTable.isHidden = unlocked
           unlockLabelNodeForTable.isHidden = unlocked
           
           tableNode.texture = SKTexture(imageNamed: table.Sprite!)
           
           tableNode.size = CGSize(width: tableNode.texture!.size().width * CGFloat(table.XScale!.floatValue), height: tableNode.texture!.size().height * CGFloat(table.YScale!.floatValue))
           
           tableNode.position = CGPoint(x: self.frame.midX, y: self.frame.minY - 30 + CGFloat(table.YPosition!.floatValue))
           
           lockBowForTable.position = CGPoint(x: self.frame.midX + tableNode.size.width * 0.25 + 20,
                                           y: self.frame.minY + tableNode.size.height / 2 - 100)
           unlockLabelNodeForTable.text = "\(table.MinFlips!.intValue)"
           unlockLabelNodeForTable.position = CGPoint(x: unlockLabelNodeForTable.frame.size.height + 60,
                                              y: -unlockLabelNodeForTable.frame.size.height + 25)
           
           updateTableArrowsState()
           
       }
    
    func updateCakeArrowsState() {
        hideButton(buttonNode: leftCakeButtonNode,
                   state: Bool(truncating: selectedCakeIndex as NSNumber))
        hideButton(buttonNode: rightCakeButtonNode,
                   state: selectedCakeIndex != totalCakes - 1)
    }
    
    func updateTableArrowsState() {
        hideButton(buttonNode: leftTableButtonNode,
                   state: Bool(truncating: selectedTableIndex as NSNumber))
        hideButton(buttonNode: rightTableButtonNode,
                   state: selectedTableIndex != totalTables - 1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            // play button is pressed
            if playButtonNode.contains(location) {
                
                selectedCakeIndex = ItemController.getSaveIndex(key: "SelectedCake")
                selectedTableIndex = ItemController.getSaveIndex(key: "SelectedTable")
                let selectedItem = cakes[selectedCakeIndex]
                let selectedTable = tables[selectedTableIndex]
                
                if flipsAmount >= selectedItem.MinFlips!.intValue && flipsAmount >= selectedTable.MinFlips!.intValue {
                    SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                    startGame()
                } else {
                     SKTAudio.sharedInstance().playSoundEffect(filename: "fail.mp3")
                }
            }
            
            if leftCakeButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let itemIndex = selectedCakeIndex - 1
                if itemIndex >= 0 {
                    updateByCakeIndex(itemIndex)
                }
            }
            
            if rightCakeButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let nextIndex = selectedCakeIndex + 1
                if nextIndex < totalCakes {
                    updateByCakeIndex(nextIndex)
                }
            }
            
            if leftTableButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let tableIndex = selectedTableIndex - 1
                if tableIndex >= 0 {
                    updateByTableIndex(tableIndex)
                }
            }
                      
            if rightTableButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let nextIndex = selectedTableIndex + 1
                if nextIndex < totalTables {
                    updateByTableIndex(nextIndex)
                }
            }
        }
    }
    
    func updateByCakeIndex(_ index: Int) {
        let cake = cakes[index]
        selectedCakeIndex = index
        updateSelectedCake(cake)
        ItemController.saveSelected(selectedCakeIndex, key: "SelectedCake" )
    }
    
    func updateByTableIndex(_ index: Int) {
        let table = tables[index]
        selectedTableIndex = index
        updateSelectedTable(table)
        ItemController.saveSelected(selectedTableIndex, key: "SelectedTable")
    }
    
    func pulseLockNode(_ node: SKSpriteNode) {
        let scaleDown = SKAction.scale(to: 0.178, duration: 0.5)
        let scaleUp = SKAction.scale(to: 0.13, duration: 0.5)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        
        node.run(SKAction.repeatForever(sequence))
    }

    func startGame () {
        let userData: NSMutableDictionary = ["cake" : cakes[selectedCakeIndex]]
       userData["table"] = tables[selectedTableIndex]
        changeToSceneBy(nameScene: "GameScene", userData: userData)
    }
}
 
