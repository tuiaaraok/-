//
//  ButtonNode.swift
//  Somersault
//
//  Created by Айсен Шишигин on 25/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class ButtonNode: SKSpriteNode {

    init(imageNode: String, position: CGPoint?, xScale: CGFloat, yScale: CGFloat) {
        
        let texture = SKTexture(imageNamed: imageNode)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.position = position ?? CGPoint(x: 0, y: 0)
        self.xScale = xScale
        self.yScale = yScale
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
