//
//  FolderViewModel.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 09/01/25.
//

import Foundation
import CoreData
import SwiftUI

class FolderViewModel: ObservableObject {
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    @Published var folders: [Folder] = []
    
    func createFolder(name: String, color: String?, favourite: Bool) {
        let folder = Folder(context: context)
        folder.id = UUID()
        folder.name = name
        folder.color = color
        folder.favourite = favourite
        folder.creation = Date()

        saveContext()
    }
    
    func addFileToFolder(named folderName: String, fileName: String, fileData: Data) {
        
        let folder = fetchFolder(named: folderName)
        
        if let folder = folder {
            print("File Data \(fileData)")
            print("File Name\(fileName)" )
            addFile(to: folder, name: fileName, data: fileData)
        } else {
            print("Folder not found!")
        }
    }

    func addFile(to folder: Folder, name: String,data: Data) {
        let file = File(context: context)
        file.name = name
        file.creationDate = Date()
        file.data = data
        file.folder = folder

        folder.addToFiles(file)

        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save: \(error.localizedDescription)")
        }
    }
    
    func fetchFolders() -> [Folder] {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Folder.creation, ascending: true)]
        
        do {
            let folders = try context.fetch(fetchRequest)
            return folders
        } catch {
            print("Failed to fetch folders: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchFolder(named folderName: String) -> Folder? {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", folderName)
        
        do {
            let folders = try context.fetch(fetchRequest)
            return folders.first
        } catch {
            print("Failed to fetch folder by name: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateFavouriteStatus(for folderName: String, to favourite: Bool) {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", folderName)
        
        do {
            let folders = try context.fetch(fetchRequest)
            if let folder = folders.first {
                folder.favourite = favourite
                saveContext()
                print("Updated favourite status for folder '\(folderName)' to \(favourite)")
            } else {
                print("Folder with name '\(folderName)' not found.")
            }
        } catch {
            print("Failed to update favourite status: \(error.localizedDescription)")
        }
    }
}
