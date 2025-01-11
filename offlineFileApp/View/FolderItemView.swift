//
//  FolderItemView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 10/01/25.
//

import Foundation
import SwiftUI
import UIKit
import CoreData

struct FolderItemView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UICollectionViewController
    
    @FetchRequest(entity: Folder.entity(), sortDescriptors: []) private var folders: FetchedResults<Folder>
    //    var folders: [Folder]
    var context: NSManagedObjectContext
    var onSelectFolder: (Folder) -> Void
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: 100, height: 120)
        return layout
    }()
    
    func makeUIViewController(context: Context) -> UICollectionViewController {
        let collectionViewController = UICollectionViewController(collectionViewLayout: layout)
        collectionViewController.collectionView.register(FolderCollectionViewCell.self, forCellWithReuseIdentifier: "FolderCell")
        collectionViewController.collectionView.backgroundColor = .systemBackground
        collectionViewController.collectionView.delegate = context.coordinator
        collectionViewController.collectionView.dataSource = context.coordinator
        return collectionViewController
    }
    func updateUIViewController(_ uiViewController: UICollectionViewController, context: Context) {
        context.coordinator.updateData(folders)
        uiViewController.collectionView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(folders: folders, onSelectFolder: onSelectFolder)
    }
    
    class Coordinator: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
        private var folders: FetchedResults<Folder>
        private var onSelectFolder: (Folder) -> Void
        
        init(folders: FetchedResults<Folder>, onSelectFolder: @escaping (Folder) -> Void) {
            self.folders = folders
            self.onSelectFolder = onSelectFolder
        }
        func updateData(_ newFolders: FetchedResults<Folder>) {
            self.folders = newFolders
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return folders.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FolderCell", for: indexPath) as? FolderCollectionViewCell else {
                fatalError("Unable to dequeue FolderCollectionViewCell")
            }
            let folder = folders[indexPath.item]
            cell.configure(with: folder)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard indexPath.item < folders.count else { return }
            let folder = folders[indexPath.item]
            print(folder)
            onSelectFolder(folder)
        }
    }
    
}


//struct FolderItemView: View {
//    @Environment(\.managedObjectContext) private var context
//    @ObservedObject var folder: Folder
//    @ObservedObject var viewModel: FolderViewModel
//
//    var body: some View {
//        ZStack(alignment: .topTrailing) {
//            VStack {
//                Image(systemName: "folder.fill")
//                    .resizable()
//                    .frame(width: 50, height: 50)
//                    .foregroundColor(Color(hex: folder.color!))
//                Text(folder.name!)
//                    .font(.caption)
//                    .foregroundColor(.primary)
//                let creationDateTime = DateFormatter.dateFormatter.string(from: folder.creation!)
//                Text(creationDateTime)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//            }
//            .padding()
//            //            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
//
//
//            Button(action: toggleFavourite) {
//                Image(systemName: folder.favourite ? "heart.fill" : "heart")
//                    .foregroundColor(folder.favourite ? .red : .gray)
//                    .padding(8)
//                    .background(Color.white)
//                    .clipShape(Circle())
//                    .shadow(radius: 2)
//
//            }
//            .frame(width: 8, height: 8)
//            .opacity(0.8)
//            .offset(x: -15, y: 15)
//        }
//    }
//    private func toggleFavourite() {
//        viewModel.updateFavouriteStatus(for: folder.name!, to: !folder.favourite)
//    }
//}
