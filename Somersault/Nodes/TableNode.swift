//
//  TableNode.swift
//  Somersault
//
//  Created by Айсен Шишигин on 27/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import UIKit
import SpriteKit

class TableNode: SKSpriteNode {
    init(_ table: Table) {
        let texture = SKTexture(imageNamed: table.Sprite!)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width - 40, height: self.size.height - 30))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.restitution = 0
        self.zPosition = 1
        self.xScale = 1.3
        self.yScale = 1.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
