//
//  GroceryDetails.swift
//  ListAndNavigationTutorial
//
//  Created by Tiffany Le on 4/3/25.
//

import SwiftUI

// view shows detail of a selected grocery item
struct GroceryDetails: View {
    
    // grocery item to display
    let selectedItem: GroceryItem
    
    // controls whether the description is shown or hidden
    @State private var showDescription = true
    var body: some View {
        Form {
            Section(header: Text("Grocery Item Details")) {
                // display item image if either uploaded or preset with the app
                if let imageData = selectedItem.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else { // use default image (logo)
                    Image(selectedItem.imageName.isEmpty ? "logo" : selectedItem.imageName)
                        .resizable()
                        .cornerRadius(10)
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                // favorite toggle (heart icon)
                HStack {
                    Text("Favorite")
                        .font(.headline)
                    Spacer()
                    Image(systemName: selectedItem.isLiked ? "heart.fill" : "heart")
                        .foregroundColor(selectedItem.isLiked ? .red : .gray)
                }
                // item name
                Text(selectedItem.name)
                    .font(.headline)
                
                // toggle to show or hide the description
                Toggle("Show Description", isOn: $showDescription)
                
                // description text
                if showDescription {
                    Text(selectedItem.description)
                        .transition(.opacity)
                }
                
                // cost display
                HStack {
                    Text("Cost")
                        .font(.headline)
                    Spacer()
                    Text(selectedItem.cost).font(.body)
                }
                
                // refrigeration status
                HStack {
                    Text("Needs Refrigeration")
                        .font(.headline)
                    Spacer()
                    
                    Image(systemName: selectedItem.isCold ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(selectedItem.isCold ? .green : .gray)
                }
            }
        }
    }
}
