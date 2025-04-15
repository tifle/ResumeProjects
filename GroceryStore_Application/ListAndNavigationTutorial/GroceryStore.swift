//
//  GroceryStore.swift
//  ListAndNavigationTutorial
//
//  Created by Tiffany Le on 4/1/25.
//

import Foundation
import SwiftUI

// class that holds a list of grocery items
// observable so SWIFTUI can update the UI when data changes
// confirms to identifiable so it can be used in Swift
@Observable class GroceryStore: Identifiable {
    // array to store all items in the "store"
    var groceryItems: [GroceryItem]
    
    // optional input list of items
    // if nothing is passed, it will start as an empty list
    init (groceryItems: [GroceryItem] = []){
        self.groceryItems = groceryItems
    }
}
