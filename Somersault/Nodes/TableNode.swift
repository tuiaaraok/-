//
//  TableNode.swift
//  Somersault
//
//  Created by Айсен Шишигин on 27/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class TableNode: SKSpriteNode {
    init(_ table: Table) {
        let texture = SKTexture(imageNamed: table.Sprite!)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.xScale = 1.3
        self.yScale = 1.3
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.restitution = 0
        self.zPosition = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
