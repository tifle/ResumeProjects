//
//  ContentView.swift
//  ListAndNavigationTutorial
//
//  Created by Tiffany Le on 4/1/25.
//

import SwiftUI

struct ContentView: View {
    // State variables for managing the grocery store, navigation, and edit mode
    @State var groceryStore: GroceryStore = GroceryStore(groceryItems: groceryData)
    // used for navigationStack
    @State private var stackPath = NavigationPath()
    // Controls list edit state
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack(path: $stackPath) {
            // App logo at the top of the screen
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            // Title text below logo
            Text("Our Products")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            
            // Add Item Button (Navigation Link to the Add Item view)
            NavigationLink(value: "Add Item") {
                Text("+ Add Item")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            // Toggle Edit/Done Button for editing
            Button(action: {
                withAnimation {
                    editMode = (editMode == .active) ? .inactive : .active
                }
            }) {
                Text(editMode == .active ? "Done" : "Edit")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            
            // Main list displaying the grocery items
            List {
                // Loop over each item in the store and show a row
                ForEach(groceryStore.groceryItems) { groceryItem in
                    NavigationLink(value: groceryItem) {
                        ListCell(groceryItem: groceryItem)
                    }
                }
                // Swipe to delete functionality
                .onDelete(perform: deleteItems)
                // Drag to reorder
                .onMove(perform: moveItems)
            }
            // navigate to grocery details view when an item is tapped/clicked
            .navigationDestination(for: GroceryItem.self) { selectedItem in
                GroceryDetails(selectedItem: selectedItem)
            }
            // navigate to additem view when the "Add item" is clicked
            .navigationDestination(for: String.self) { _ in
                AddItem(groceryStore: self.groceryStore, path: $stackPath)
            }
            // bind edit mode environment value
            .environment(\.editMode, $editMode)
        }
        .padding()
    }
    
    // Delete selected items from the list
    func deleteItems(at offsets: IndexSet) {
        groceryStore.groceryItems.remove(atOffsets: offsets)
    }
    
    // Move items throughout the list
    func moveItems(from source: IndexSet, to destination: Int) {
        // Ensure the groceryStore.cars groceryItems gets updated correctly
        groceryStore.groceryItems.move(fromOffsets: source, toOffset: destination)
    }
}

// Xcode canvas preview
#Preview {
    ContentView()
}

// One row in the list
struct ListCell: View {
    // Object
    var groceryItem: GroceryItem

    var body: some View {
        // If item has image data, then display
        if let data = groceryItem.imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 60)
                .cornerRadius(8)
        } else {
            // Show default image (Trader Tiff logo)
            Image(groceryItem.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 60)
                .cornerRadius(8)
        }
        
        // Show car's name next to the image
        Text(groceryItem.name)
    }
}
