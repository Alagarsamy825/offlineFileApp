//
//  CreateFolder.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 08/01/25.
//

import Foundation
import SwiftUI

struct AddFolderView: View {
    @State private var folderName: String = ""
    @State private var selectedColor: Color = .default
    @Binding var isPresented: Bool
    @Binding var folders: [(name: String, color: Color, creation: Date)] // Update to store name and color

    var body: some View {
        NavigationView {
            Form {
                TextField("Folder Name", text: $folderName)
                
                // Color Picker
                ColorPicker("Pick a Folder Color", selection: $selectedColor)
                    .padding()
            }
            .navigationTitle("Add New Folder")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if !folderName.isEmpty {
                            // Add folder with both name and color
                            folders.append((name: folderName, color: selectedColor, creation: Date()))
                            isPresented = false
                        }
                    }
                    .disabled(folderName.isEmpty)
                }
            }
        }
    }
}

struct AddFolderView_Previews: PreviewProvider {
    static var previews: some View {
        AddFolderView(isPresented: .constant(true), folders: .constant([]))
    }
}
