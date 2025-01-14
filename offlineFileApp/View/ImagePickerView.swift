//
//  ImagePickerView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 12/01/25.
//

import Foundation
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView
        
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
