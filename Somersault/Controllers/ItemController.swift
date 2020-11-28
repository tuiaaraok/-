//
//  ItemController.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class ItemController {
    
    class func readCakes() -> [Cake] {
        var items = [Cake]()
        if let path = Bundle.main.path(forResource: "Cakes", ofType: "plist"), let plistArray = NSArray(contentsOfFile: path) as? [[String : Any]] {
            for dic in plistArray {
                let item = Cake(itemDictionary: dic as NSDictionary)
                items.append(item)
            }
        }
        return items
    }
    
    class func saveSelected(_ index: Int, key: String) {
        UserDefaults.standard.set(index, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getSaveIndex(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func readTables() -> [Table] {
        var tables = [Table]()
        if let path = Bundle.main.path(forResource: "Tables", ofType: "plist"), let plistArray = NSArray(contentsOfFile: path) as? [[String : Any]] {
            for dic in plistArray {
                let table = Table(tableDictionary: dic as NSDictionary)
                tables.append(table)
            }
        }
        return tables
    }
    
    class func readBg() -> [Background] {
        var backgrounds = [Background]()
        if let path = Bundle.main.path(forResource: "Backgrounds", ofType: "plist"), let plistArray = NSArray(contentsOfFile: path) as? [[String : Any]] {
            for dic in plistArray {
                let bg = Background(bgDictionary: dic as NSDictionary)
                backgrounds.append(bg)
            }
        }
        return backgrounds
    }
}
