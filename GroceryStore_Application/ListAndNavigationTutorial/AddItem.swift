//
//  AddItem.swift
//  ListAndNavigationTutorial
//
//  Created by Tiffany Le on 4/3/25.
//

// import packages
import Foundation
import SwiftUI
import _PhotosUI_SwiftUI

// View for adding a new grocery items
struct AddItem: View {
    // reference to the store where the item will be added
    @State var groceryStore: GroceryStore
    
    // item attributes
    @State var isCold = false
    @State var name: String = ""
    @State var description: String = ""
    @State var cost: String = ""
    @State var isLiked = false
    
    // used for navigation stack control
    @Binding var path: NavigationPath
    
    // used for handling optional image uploads
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        Form {
            // Item Details Section
            Section (header: Text("Item Details")) {
                // display cart icon
                Image(systemName: "cart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                // take in inputs for name, description, cost
                DataInput(title: "Name", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                DataInput(title: "Cost", userInput: $cost)
                
                // Toggle Button for Refrigeration Requirement
                Toggle(isOn: $isCold) {
                    Text("Needs Refrigeration")
                        .font(.headline)
                        .foregroundColor(isCold ? .green : .gray)
                }
                .tint(isCold ? .green : .red)
                
                // Heart icon toggle to determine "Favorite" status
                HStack {
                    Text("Favorite?")
                        .font(.headline)
                        .foregroundColor(isLiked ? .red : .gray)
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .foregroundColor(isLiked ? .red : .gray)
                        .font(.largeTitle)
                        // animation for toggling heart symbol
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isLiked.toggle()
                            }
                        }
                }
                .font(.title2)
                .padding(.top, 10)
            }
            // SECTION: Add Photo
            Section(header: Text("Optional Photo")) {
                // show image preview if image has been selected
                if let imageData = selectedImageData,
                   let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .cornerRadius(10)
                } else { // show default image if nothing was selected (logo)
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .foregroundColor(.gray)
                }
                // button to open photo picker
                PhotosPicker("Upload Photo", selection: $selectedPhotoItem, matching: .images)
                    .onChange(of: selectedPhotoItem) { newItem in
                        // load image when photo is selected
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
            }
            // "Add Item" Button
            Button (action: AddNewItem) {
                Text("Add Item")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle()) // prevent default blue text button
        }
    }
    // FUNCTION: add item to the list
    func AddNewItem() {
        // create a new grocery item with the data
        let newItem = GroceryItem(
            id: UUID().uuidString,
            name: name,
            description: description,
            cost: cost,
            isCold: isCold,
            isLiked: isLiked,
            imageName: "logo", // default image
            imageData: selectedImageData // store uploaded image
        )
        // add new item to the list
        groceryStore.groceryItems.append(newItem)
        // go back to the previous/home screen
        path.removeLast()
    }
    
}
// reusable view for input fields
struct DataInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
            // text field bound to user input
            TextField("Enter .\(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
