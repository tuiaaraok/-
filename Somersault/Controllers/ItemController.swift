//
//  ItemController.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class ItemController {
    
    class func saveSelected(_ index: Int, key: String) {
        UserDefaults.standard.set(index, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func getSaveIndex(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func readItem(key: String) -> [Item] {
           var items = [Item]()
           if let path = Bundle.main.path(forResource: key, ofType: "plist"), let plistArray = NSArray(contentsOfFile: path) as? [[String : Any]] {
               for dic in plistArray {
                var item: Item!
                switch key {
                case "Backgrounds":
                    item = Background(bgDictionary: dic as NSDictionary)
                case "Cakes":
                    item = Cake(itemDictionary: dic as NSDictionary)
                case "Tables":
                    item = Table(tableDictionary: dic as NSDictionary)
                default:
                    break
                }
                   items.append(item)
               }
           }
           return items
       }
}
