//
//  FolderGridView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 10/01/25.
//

import Foundation
import SwiftUI

struct FolderGridView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(entity: Folder.entity(),
                  sortDescriptors: [/*NSSortDescriptor(key: "name", ascending: true)*/],
                  animation: .default) private var folders: FetchedResults<Folder>
    
    @State private var showAddFolder = false
    @State private var selectedSortOption: SortOption = .name
    @ObservedObject var viewModel: FolderViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if folders.isEmpty {
                    Text("No folders available")
                        .foregroundColor(.gray)
                        .italic()
                        .padding()
                }
                else {
                    
                    FolderItemView(context: context) { folder in
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootVC = windowScene.windows.first?.rootViewController {
                            let fileListView = NavigationView {
                                FileListView(folder: folder, viewModel: FolderViewModel(context: context))
                            }
                            let hostingController = UIHostingController(rootView: fileListView)
                            hostingController.modalPresentationStyle = .overFullScreen
                            rootVC.present(hostingController, animated: true, completion: nil)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Folders")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Sort by Name") {
                            selectedSortOption = .name
                        }
                        
                        Button("Sort by Date") {
                            selectedSortOption = .date
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddFolder = true
                    }) {
                        Image(systemName: "folder.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $showAddFolder) {
                AddFolderView(isPresented: $showAddFolder)
            }
        }
    }
}

