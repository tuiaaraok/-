//
//  Model.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

protocol Item {
    var Sprite: String? { get set }
    var XScale: NSNumber? { get set }
    var YScale: NSNumber? { get set }
    var MinFlips: NSNumber? { get set }
}

class Cake: Item {
    
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

class Table: Item {
    
    var Sprite: String?
    var MinFlips: NSNumber?
    var XScale: NSNumber?
    var YScale: NSNumber?
    var YPosition: NSNumber?
    
    init(tableDictionary: NSDictionary) {
        self.Sprite = tableDictionary["Sprite"] as? String
        self.MinFlips = tableDictionary["MinFlips"] as? NSNumber
        self.XScale = tableDictionary["XScale"] as? NSNumber
        self.YScale = tableDictionary["XScale"] as? NSNumber
        self.YPosition = tableDictionary["YPosition"] as? NSNumber
        
    }
}

class Background: Item {
    
    var Sprite: String?
    var MinFlips: NSNumber?
    var XScale: NSNumber?
    var YScale: NSNumber?
    
    init(bgDictionary: NSDictionary) {
        self.Sprite = bgDictionary["Sprite"] as? String
        self.MinFlips = bgDictionary["MinFlips"] as? NSNumber
        self.XScale = bgDictionary["XScale"] as? NSNumber
        self.YScale = bgDictionary["XScale"] as? NSNumber
    }
}

