//
//  CreateFolder.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 08/01/25.
//

import Foundation
import SwiftUI

struct AddFolderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var isPresented: Bool
    
    @State private var folderName: String = ""
    @State private var selectedColor: Color = .default
    @State private var isFavourite: Bool = false
   
    var body: some View {
        NavigationView {
            Form {
                TextField("Folder Name", text: $folderName)
                ColorPicker("Pick a Folder Color", selection: $selectedColor)
                    .padding()
                Toggle("Mark as Favorite", isOn: $isFavourite)
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
                            let folderColor = UIColor(selectedColor).toHexString()
                            FolderViewModel(context: viewContext).createFolder(
                                name: folderName, color: folderColor, favourite: isFavourite)
                            isPresented = false
                        }
                    }
                    .disabled(folderName.isEmpty)
                }
            }
        }
    }
}

//struct AddFolderView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFolderView(isPresented: .constant(true), folders: .constant([]))
//    }
//}

