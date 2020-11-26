//
//  ItemController.swift
//  Somersault
//
//  Created by Айсен Шишигин on 26/11/2020.
//  Copyright © 2020 Туйаара Оконешникова. All rights reserved.
//

import Foundation

class ItemController {
    
    class func readItems() -> [Item] {
        
        var items = [Item]()
        
        if let path = Bundle.main.path(forResource: "Items", ofType: "plist"), let plistArray = NSArray(contentsOfFile: path) as? [[String : Any]] {
            for dic in plistArray {
                let item = Item(itemDictionary: dic as NSDictionary)
                items.append(item)
            }
        }
        return items
    }
    
    class func saveSelectedItem(_ index: Int) {
        UserDefaults.standard.set(index, forKey: "SelectedItem")
        UserDefaults.standard.synchronize()
    }
    
    class func getSaveItemIndex() -> Int {
        return UserDefaults.standard.integer(forKey: "SelectedItem")
    }
}
