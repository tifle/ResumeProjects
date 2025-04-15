//
//  GroceryItem.swift
//  ListAndNavigationTutorial
//
//  Created by Tiffany Le on 4/1/25.
//

import Foundation

// define the structure/model for each grocery item
// conform to codable
// identifiable for list and hashable for comparison
struct GroceryItem : Codable, Identifiable, Hashable {
    var id: String // unique identifier
    var name: String // name of grocery item
    var description: String // description of item
    var cost: String // cost of item
    var isCold: Bool // indicate if item needs to be kept cold
    var isLiked: Bool // indicate if user favorites or liked the item
    var imageName: String // name of image asset
    var imageData: Data? = nil // For user-uploaded images
}
