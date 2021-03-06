//
//  LabelNode.swift
//  Somersault
//
//  Created by Айсен Шишигин on 25/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class LabelNode: SKLabelNode {
    
    convenience init(text: String, fontSize: CGFloat, position: CGPoint?) {
        self.init(fontNamed: uiFont) 
        self.text = text
        self.fontSize = fontSize
        self.position = position ?? CGPoint(x: 0, y: 0)
        self.fontColor = .black
        self.zPosition = 1
    }
}
