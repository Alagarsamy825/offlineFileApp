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
                        
                        HStack {
                            
                            if let data = file.data, let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                    .frame(width: 80, height: 80)
                                
                            }
                            else {
                                Image("file")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                                    .frame(width: 80, height: 80)
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                Text(file.name ?? "")
                                    .font(.headline)
                                    .lineLimit(1)
                                Text("Created on \(file.creationDate ?? Date(), formatter: dateFormatter)")
                                    .font(.subheadline)
                            }
                            
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
                    .frame(width: 12, height: 20)
                    .foregroundColor(.blue)
                Text(folder.name!)
                    .foregroundColor(.blue)
                    .font(.headline)
            }
        })
        .onChange(of: selectedImage) { newImage in
            if let image = newImage {
                print("Selected Image: \(image)")
                
                let folderName = folder.name ?? "DefaultFolder"
                let fileName = (UUID().uuidString) + ".jpg"
                
                // Save the image to the folder
                do {
                    let imageData = try saveImageToFolder(image: image)
                    viewModel.addFileToFolder(named: folderName, fileName: fileName, fileData: imageData)
                    print("Image data successfully saved.")
                } catch ImageSaveError.conversionFailed {
                    print("Failed to convert image to data.")
                } catch {
                    
                    print("An unexpected error occurred: \(error.localizedDescription)")
                }
            }
        }
        .onChange(of: selectedDocument) { newDocument in
            if let documentData = newDocument {
                print("Selected Document: \(selectedDocumentText ?? "Unknown")")
                
                let folderName = folder.name ?? "DefaultFolder"
                let fileName = selectedDocumentText ?? "document.pdf"
                
                // Save the document to the folder
                viewModel.addFileToFolder(named: folderName, fileName: fileName, fileData: documentData)
                print("Document data successfully saved.")
            }
        }
        
    }
    
    func saveImageToFolder(image: UIImage) throws -> Data {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Error: Could not convert image to data")
            throw ImageSaveError.conversionFailed
        }
        return imageData
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }
}
