//
//  FileListView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 09/01/25.
//

import Foundation
import SwiftUI

struct FileListView: View {
    @ObservedObject var folder: Folder
    @State private var isAddingFolder = false
    @State private var selectedOption: String? = nil
    @Environment(\.dismiss) private var dismiss
    
    var viewModel: FolderViewModel
    
    @State private var pickerType: PickerType?
    
    @State private var selectedImage: UIImage?
    @State private var selectedDocument: Data?
    @State private var selectedDocumentText: String?
    

    var body: some View {
        VStack {
            if folder.files == [] {
                Text("No files available")
                    .foregroundColor(.gray)
                    .italic()
                    .padding()
            }
            else {
                List() {
                    ForEach(folder.files?.allObjects as? [File] ?? [], id: \.self) { file in
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Image(uiImage: UIImage(named: file.name ?? "") ?? UIImage())
                                .resizable()
                                .frame(width: 40, height: 40)
                                .scaledToFit()
                            Text(file.name ?? "")
                                .font(.headline)
                            Text("Created on \(file.creationDate ?? Date(), formatter: dateFormatter)")
                                .font(.subheadline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.vertical, 2)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
        }
        .sheet(item: self.$pickerType, onDismiss: {
            print("dismiss")
        }, content: { item in
            switch item {
            case .cameraRoll:
                ImagePickerView(image: self.$selectedImage)
            case .files:
                DocumentPickerView(file: $selectedDocument, fileName: $selectedDocumentText)
            }
        })
        
        .navigationTitle(folder.name ?? "Folder")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isAddingFolder = true
                }) {
                    Image(systemName: "plus")
                }
                .confirmationDialog("Select a type", isPresented: self.$isAddingFolder) {
                    Button("Photo") {
                        self.pickerType = .cameraRoll
                        
                    }
                    Button("File") {
                        self.pickerType = .files
                    }
                }
            }
        }

        .navigationBarItems(leading: Button(action: {
            dismiss()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 12, height: 20) // Adjust size as needed
                    .foregroundColor(.blue)
                Text(folder.name!)
                    .foregroundColor(.blue)
                    .font(.headline)
            }
        })
        
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
}
