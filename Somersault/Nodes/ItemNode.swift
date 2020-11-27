//
//  ItemNose.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class ItemNode: SKSpriteNode {

    init(_ item: Item) {
        let texture = SKTexture(imageNamed: item.Sprite!)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.physicsBody = SKPhysicsBody(texture: self.texture!, size: texture.size())
        self.xScale = CGFloat(item.XScale!.floatValue)
        self.yScale = CGFloat(item.YScale!.floatValue)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.angularDamping = 0.25
        self.physicsBody?.mass = CGFloat(item.Mass!.doubleValue)
        self.physicsBody?.restitution = CGFloat(item.Restitution!.doubleValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
