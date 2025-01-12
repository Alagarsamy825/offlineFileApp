//
//  DocumentPickerView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 12/01/25.
//

import Foundation
import SwiftUI
import UIKit

struct DocumentPickerView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context){
        
    }
    
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.item"], in: .open)
        picker.allowsMultipleSelection = false
        picker.shouldShowFileExtensions = true
        picker.delegate = context.coordinator
        return picker
    }
    
    typealias UIViewControllerType = UIDocumentPickerViewController
    
    
    
    @Binding var file: Data?
    @Binding var fileName: String?
    
    func makeCoordinator() -> DocumentPickerView.Coordinator {
        return DocumentPickerView.Coordinator(parent1: self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent1: DocumentPickerView
        
        init(parent1: DocumentPickerView) {
            self.parent1 = parent1
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            print("[DocumentPicker]")
            guard controller.documentPickerMode == .open, let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            DispatchQueue.main.async {
                url.stopAccessingSecurityScopedResource()
                print("Stop accessing")
            }
            do {
                let document = try Data(contentsOf: url.absoluteURL)
                self.parent1.file = document
                self.parent1.fileName = url.lastPathComponent
                print("File Selected:" + url.path)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
