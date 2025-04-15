//
//  GroceryData.swift
//  ListAndNavigationTutorial
//
//  Created by Tiffany Le on 4/1/25.
//

import Foundation
import UIKit
import SwiftUI

// load the grocery data from a local JSON file
var groceryData: [GroceryItem] = loadJson("groceryData.json")

// generic function to load & decode JSON file into a Swift object
func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    // attempt to locate the JSON file in the app bundle
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else { // stop app if file is missing
        fatalError("\(filename) not found.")
    }
    do { // try to load the contents of the file
        data = try Data(contentsOf: file)
    } catch { // stop app if loading failed
        fatalError("Could not load \(filename): \(error)")
    }
    do {
        //translating each of the json elements into an object in swift
        //specifically an array of objects
        return try JSONDecoder().decode(T.self, from: data)
    } catch { // stop add if parsing failed
        fatalError("Unable to parse \(filename): \(error)")
    }
}

