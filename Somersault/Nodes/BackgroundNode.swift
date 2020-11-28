//
//  BackgroundNode.swift
//  Somersault
//
//  Created by Айсен Шишигин on 28/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class BackgroundNode: SKSpriteNode {
    init(_ bg: Background) {
        let texture = SKTexture(imageNamed: bg.Sprite!)
        super.init(texture: texture, color: .clear, size: texture.size())
        
        self.zPosition = -3
        self.xScale = 1.3
        self.yScale = 1.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
