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
    var bgNode = SKSpriteNode()
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
    var lockBowForBg = SKSpriteNode()
    var unlockLabelNodeForBg = SKLabelNode()
    
    // variables
    var highScore = 0
    var flipsAmount = 0
    var cakes = [Cake]()
    var tables = [Table]()
    var backgrounds = [Background]()
    var selectedCakeIndex = 0
    var selectedTableIndex = 0
    var selectedBgIndex = 0
    var totalCakes = 0
    var totalTables = 0
    var totalBgs = 0

    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        cakes = ItemController.readItem(key: "Cakes") as! [Cake]
        tables = ItemController.readItem(key: "Tables") as! [Table]
        backgrounds = ItemController.readItem(key: "Backgrounds") as! [Background]
       
        totalCakes = cakes.count
        totalTables = tables.count
        totalBgs = backgrounds.count
        
        highScore = UserDefaults.standard.integer(forKey: "localHighScore")
        flipsAmount = UserDefaults.standard.integer(forKey: "flips")
        
        SKTAudio.sharedInstance().playBackgroundMusic(filename: "backgroundMusic.mp3")
        view.ignoresSiblingOrder = false
        setupUI()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        // High score
        let highScoreLabelNode = LabelNode(text: "High score",
                                           fontSize: 40,
                                           position: CGPoint(x: self.frame.midX - 100,
                                                             y: self.frame.maxY - 150))
        self.addChild(highScoreLabelNode)
        
        // High score amount
        let highScoreAmountLabelNode = LabelNode(text: String(highScore) ,
                                                 fontSize: 70,
                                                 position: CGPoint(x: self.frame.midX - 100,
                                                                   y: self.frame.maxY - 250))
        self.addChild(highScoreAmountLabelNode)
        
        // total flips label node
        let totalFlipsLabelNode = LabelNode(text: "Amount",
                                            fontSize: 40,
                                            position: CGPoint(x: self.frame.midX + 100,
                                                              y: self.frame.maxY - 150))
        self.addChild(totalFlipsLabelNode)
        
        // flips amount
        let totalFlipsAmountLabelNode = LabelNode(text: String(flipsAmount),
                                                  fontSize: 70,
                                                  position: CGPoint(x: self.frame.midX + 100,
                                                                    y: self.frame.maxY - 250))
        self.addChild(totalFlipsAmountLabelNode)
        
        // play button
        playButtonNode = ButtonNode(imageNode: "play",
                                    position: CGPoint(x: self.frame.midX, y: self.frame.midY + 15),
                                    xScale: 1.4,
                                    yScale: 1.4)
        self.addChild(playButtonNode)
        
        // MARK: - Table, cake and background nodes
        
        // Table node
        selectedTableIndex = ItemController.getSaveIndex(key: "SelectedTable")
        let selectedTable = tables[selectedTableIndex]
        tableNode = SKSpriteNode(imageNamed: selectedTable.Sprite!)
        tableNode.zPosition = 1
        self.addChild(tableNode)
        
        // Cake node
        selectedCakeIndex = ItemController.getSaveIndex(key: "SelectedCake")
        let selectedCake = cakes[selectedCakeIndex]
        cakeNode = SKSpriteNode(imageNamed: selectedCake.Sprite!)
        cakeNode.zPosition = 10
        self.addChild(cakeNode)
        
        // Bg node
        selectedBgIndex = ItemController.getSaveIndex(key: "SelectedBg")
        print(backgrounds)
        let selectedBg = backgrounds[selectedBgIndex]
        bgNode = SKSpriteNode(imageNamed: selectedBg.Sprite!)
        bgNode.zPosition = -1
        self.addChild(bgNode)
        
        // MARK: - Left and right buttons
        
        // left cake button
        leftCakeButtonNode = ButtonNode(imageNode: "left", position: CGPoint(x: self.frame.midX + leftCakeButtonNode.size.width - 130, y: self.frame.minY - leftCakeButtonNode.size.height + 170), xScale: 0.3, yScale: 0.3)
        hideButton(buttonNode: leftCakeButtonNode, state: false)
        self.addChild(leftCakeButtonNode)
        
        // right cake button
        rightCakeButtonNode = ButtonNode(imageNode: "right", position: CGPoint(x: self.frame.midX + rightCakeButtonNode.size.width + 130, y: self.frame.minY - rightCakeButtonNode.size.height + 170), xScale: 0.3, yScale: 0.3)
        hideButton(buttonNode: rightCakeButtonNode, state: true)
        self.addChild(rightCakeButtonNode)
        
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
        
        // left bg button
        leftBgButtonNode = ButtonNode(imageNode: "left", position: CGPoint(x: self.frame.midX + leftBgButtonNode.size.width - 130, y: self.frame.minY - leftBgButtonNode.size.height + 300), xScale: 0.3, yScale: 0.3)
        hideButton(buttonNode: leftBgButtonNode, state: false)
        self.addChild(leftBgButtonNode)
        
                // right bg button
        rightBgButtonNode = ButtonNode(imageNode: "right", position: CGPoint(x: self.frame.midX + rightBgButtonNode.size.width + 130, y: self.frame.minY - rightBgButtonNode.size.height + 300), xScale: 0.3, yScale: 0.3)
        hideButton(buttonNode: rightBgButtonNode, state: true)
        self.addChild(rightBgButtonNode)
        
        // MARK: - Lock elements
        
        // Lock node for cake
        lockBowForCake = ButtonNode(imageNode: "lock", position: CGPoint(x: 0, y: 0), xScale: 0.25, yScale: 0.25)
        lockBowForCake.zPosition = 25
        lockBowForCake.zRotation = 0.3
        self.addChild(lockBowForCake)
        
        // Lock node for table
        lockBowForTable = ButtonNode(imageNode: "lock", position: CGPoint(x: 0, y: 0), xScale: 0.25, yScale: 0.25)
        lockBowForTable.zPosition = 25
        lockBowForTable.zRotation = 0.3
        self.addChild(lockBowForTable)
        
        // Lock node for bg
        lockBowForBg = ButtonNode(imageNode: "lock", position: CGPoint(x: 0, y: 0), xScale: 0.25, yScale: 0.25)
        lockBowForBg.zPosition = 25
        lockBowForBg.zRotation = 0.3
        self.addChild(lockBowForBg)
       
        
        // Unlock label for cake
        unlockLabelNodeForCake = LabelNode(text: "0", fontSize: 80, position: CGPoint(x: 0, y: 0))
        unlockLabelNodeForCake.zPosition = 30
        unlockLabelNodeForCake.zRotation = 0.78
        lockBowForCake.addChild(unlockLabelNodeForCake)
        
        // Unlock label for table
        unlockLabelNodeForTable = LabelNode(text: "0", fontSize: 80, position: CGPoint(x: 0, y: 0))
        unlockLabelNodeForTable.zPosition = 30
        unlockLabelNodeForTable.zRotation = 0.78
        lockBowForTable.addChild(unlockLabelNodeForTable)
        
        // Unlock label for bg
        unlockLabelNodeForBg = LabelNode(text: "0", fontSize: 80, position: CGPoint(x: 0, y: 0))
        unlockLabelNodeForBg.zPosition = 30
        unlockLabelNodeForBg.zRotation = 0.78
        lockBowForBg.addChild(unlockLabelNodeForBg)
        
        // update selected item
        updateSelectedCake(selectedCake)
        updateSelectedTable(selectedTable)
        updateSelectedBg(selectedBg)
        
        pulseLockNode(lockBowForCake)
        pulseLockNode(lockBowForTable)
        pulseLockNode(lockBowForBg)
        
    }
    
    func hideButton(buttonNode: SKSpriteNode, state: Bool) {
        var buttonColor = #colorLiteral(red: 0.3411764706, green: 0.3529411765, blue: 0.4431372549, alpha: 0.2024026113)
               
        if state {
            buttonColor = #colorLiteral(red: 0.3411764706, green: 0.3529411765, blue: 0.4431372549, alpha: 1)
        }

        buttonNode.color = buttonColor
        buttonNode.colorBlendFactor = 1
    }
    
    // MARK: - Update selected items
    
    func updateSelectedCake (_ cake: Cake) {
        
        // update to the selected cake
        
        updateLockElements(cake, lockBowForCake, unlockLabelNodeForCake, cakeNode)
        
        cakeNode.size = CGSize(
            width: cakeNode.texture!.size().width * CGFloat(cake.XScale!.floatValue),
            height: cakeNode.texture!.size().height * CGFloat(cake.YScale!.floatValue)
        )
        
        cakeNode.position = CGPoint(x: self.frame.midX,
                                    y: self.frame.minY + cakeNode.size.height / 2 + 113)
        
        lockBowForCake.position = CGPoint(x: self.frame.midX + cakeNode.size.width * 0.25 + 20,
                                          y: self.frame.minY + cakeNode.size.height / 2 + 130)
        unlockLabelNodeForCake.text = "\(cake.MinFlips!.intValue)"
        
        unlockLabelNodeForCake.position = CGPoint(
            x: unlockLabelNodeForCake.frame.size.height + 60,
            y: -unlockLabelNodeForCake.frame.size.height + 25
        )
        updateCakeArrowsState()
    }
    
    func updateSelectedTable(_ table: Table) {

        updateLockElements(table, lockBowForTable, unlockLabelNodeForTable, tableNode)
           
        tableNode.size = CGSize(
            width: tableNode.texture!.size().width * CGFloat(table.XScale!.floatValue),
            height: tableNode.texture!.size().height * CGFloat(table.YScale!.floatValue)
        )
           
        tableNode.position = CGPoint(x: self.frame.midX,
                                     y: self.frame.minY - 30 + CGFloat(table.YPosition!.floatValue))
           
        lockBowForTable.position = CGPoint(x: self.frame.midX + tableNode.size.width * 0.25 + 20,
                                           y: self.frame.minY + tableNode.size.height / 2 - 100)
        
        unlockLabelNodeForTable.position = CGPoint(
            x: unlockLabelNodeForTable.frame.size.height + 60,
            y: -unlockLabelNodeForTable.frame.size.height + 25
        )
        unlockLabelNodeForTable.text = "\(table.MinFlips!.intValue)"
           
        updateTableArrowsState()
    }
    
    func updateSelectedBg(_ bg: Background) {
        
        updateLockElements(bg, lockBowForBg, unlockLabelNodeForBg, bgNode)
              
        bgNode.size = CGSize(
            width: bgNode.texture!.size().width * CGFloat(bg.XScale!.floatValue),
            height: bgNode.texture!.size().height * CGFloat(bg.YScale!.floatValue)
        )
              
        bgNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        if UIScreen.main.bounds.height > 800  {
            bgNode.setScale(CGFloat(1.2))
        }
              
        lockBowForBg.position = CGPoint(x: playButtonNode.frame.maxX - 20,
                                        y: playButtonNode.frame.minY - 20)
        unlockLabelNodeForBg.position = CGPoint(x: unlockLabelNodeForBg.frame.size.height + 60,
                                                y: -unlockLabelNodeForBg.frame.size.height + 25)
        unlockLabelNodeForBg.text = "\(bg.MinFlips!.intValue)"
              
        updateBgArrowsState()
    }
  
    func updateLockElements(_ item: Item, _ bow: SKSpriteNode, _ label: SKLabelNode, _ itemNode: SKSpriteNode) {
        let unlockFlips = Int(truncating: item.MinFlips!) - highScore
        let unlocked = unlockFlips <= 0

        bow.isHidden = unlocked
        label.isHidden = unlocked
           
        itemNode.texture = SKTexture(imageNamed: item.Sprite!)
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
    
    func updateBgArrowsState() {
        hideButton(buttonNode: leftBgButtonNode,
                   state: Bool(truncating: selectedBgIndex as NSNumber))
        hideButton(buttonNode: rightBgButtonNode,
                   state: selectedBgIndex != totalBgs - 1)
    }
    
    // MARK: - Touches began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            
            let location = touch.location(in: self)
            
            // play button is pressed
            if playButtonNode.contains(location) {
                
                selectedCakeIndex = ItemController.getSaveIndex(key: "SelectedCake")
                selectedTableIndex = ItemController.getSaveIndex(key: "SelectedTable")
                selectedBgIndex = ItemController.getSaveIndex(key: "SelectedBg")
                
                let selectedCake = cakes[selectedCakeIndex]
                let selectedTable = tables[selectedTableIndex]
                let selectedBg = backgrounds[selectedBgIndex]
                
                if flipsAmount >= selectedCake.MinFlips!.intValue &&
                    flipsAmount >= selectedTable.MinFlips!.intValue &&
                    flipsAmount >= selectedBg.MinFlips!.intValue {
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
            
            if leftBgButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let bgIndex = selectedBgIndex - 1
                if bgIndex >= 0 {
                    updateByBgIndex(bgIndex)
                }
            }
                      
            if rightBgButtonNode.contains(location) {
                SKTAudio.sharedInstance().playSoundEffect(filename: "pop.mp3")
                let nextIndex = selectedBgIndex + 1
                if nextIndex < totalBgs {
                    updateByBgIndex(nextIndex)
                }
            }
        }
    }
    
    // MARK: - Update index
    
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
    
    func updateByBgIndex(_ index: Int) {
        let bg = backgrounds[index]
        selectedBgIndex = index
        updateSelectedBg(bg)
        ItemController.saveSelected(selectedBgIndex, key: "SelectedBg")
    }
    
    // MARK: Pulse animation for lock elements
    
    func pulseLockNode(_ node: SKSpriteNode) {
        let scaleDown = SKAction.scale(to: 0.178, duration: 0.5)
        let scaleUp = SKAction.scale(to: 0.13, duration: 0.5)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        
        node.run(SKAction.repeatForever(sequence))
    }

    func startGame () {
        let userData: NSMutableDictionary = ["cake" : cakes[selectedCakeIndex]]
        userData["table"] = tables[selectedTableIndex]
        userData["bg"] = backgrounds[selectedBgIndex]
        changeToSceneBy(nameScene: "GameScene", userData: userData)
    }
}
 
