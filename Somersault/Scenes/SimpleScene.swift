//
//  SimpleScene.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import SpriteKit

class SimpleScene: SKScene {
    
    func changeToSceneBy(nameScene: String, userData: NSMutableDictionary) {
        
        let scene = (nameScene == "GameScene") ? GameScene(size: self.size) : MenuScene(size: self.size)
        
        let transition = SKTransition.fade(with: uiBackgroundColor, duration: 0.3)
        
        scene.scaleMode = .aspectFill
        scene.userData = userData
        
        self.view?.presentScene(scene, transition: transition)
    }
    
    func playSoundsEffects(_ action: SKAction) {
        run(action)
    }
}
