//
//  MenuScene.swift
//  Somersault
//
//  Created by Айсен Шишигин on 25/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    var playButtonNode = SKSpriteNode()
    var tableNode = SKSpriteNode()
    var cake1Node = SKSpriteNode()
    var highScore = 0
    var flipsAmount = 0

    override func didMove(to view: SKView) {
        self.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        setupUI()
    }
    
    func setupUI() {
        // logo node
        let logo = ButtonNode(imageNode: "", position: CGPoint(x: self.frame.midX, y: self.frame.maxY - 100), xScale: 1, yScale: 1)
        self.addChild(logo)
        
        // High score
        let highScoreLabelNode = LabelNode(text: "High score", fontSize: 20, position: CGPoint(x: self.frame.midX - 100, y: self.frame.maxY - 165), fontColor: .black)
        self.addChild(highScoreLabelNode)
        
        // High score amount
        let highScoreAmountLabelNode = LabelNode(text: String(highScore) , fontSize: 70, position: CGPoint(x: self.frame.midX - 100, y: self.frame.maxY - 250), fontColor: .black)
        self.addChild(highScoreAmountLabelNode)
        
        // total flips label node
        let totalFlipsLabelNode = LabelNode(text: "Amount", fontSize: 20, position: CGPoint(x: self.frame.midX + 100, y: self.frame.maxY - 165), fontColor: .black)
        self.addChild(totalFlipsLabelNode)
        
        // flips amount
        let totalFlipsAmountLabelNode = LabelNode(text: String(flipsAmount) , fontSize: 70, position: CGPoint(x: self.frame.midX + 100, y: self.frame.maxY - 250), fontColor: .black)
        self.addChild(totalFlipsAmountLabelNode)
        
        // play button
        playButtonNode = ButtonNode(imageNode: "", position: CGPoint(x: self.frame.midX, y: self.frame.midY - 15), xScale: 0.9, yScale: 0.9)
        self.addChild(playButtonNode)
        
        // Table node
        tableNode = ButtonNode(imageNode: "table", position: CGPoint(x: self.frame.midX, y: self.frame.minY + 30), xScale: 1.3, yScale: 1.3)
        tableNode.zPosition = 3
        self.addChild(tableNode)
        
        // Bottle node
        cake1Node = SKSpriteNode(imageNamed: "cake_1")
        cake1Node.zPosition = 10
        self.addChild(cake1Node)
        
        // 
    }
}
