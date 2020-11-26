//
//  Model.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class Item {
    var Sprite: String?
    var Mass: NSNumber?
    var Restitution: NSNumber?
    var XScale: NSNumber?
    var YScale: NSNumber?
    var MinFlips: NSNumber?
    
    init(itemDictionary: NSDictionary) {
        self.Sprite = itemDictionary["Sprite"] as? String
        self.Mass = itemDictionary["Mass"] as? NSNumber
        self.Restitution = itemDictionary["Restitution"] as? NSNumber
        self.XScale = itemDictionary["XScale"] as? NSNumber
        self.YScale = itemDictionary["XScale"] as? NSNumber
        self.MinFlips = itemDictionary["MinFlips"] as? NSNumber
    }
}
