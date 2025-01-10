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
                  sortDescriptors: [],
                  animation: .default) private var folders: FetchedResults<Folder>
    
    @State private var showAddFolder = false
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
                    GeometryReader { geometry in
                        let columnsCount = geometry.size.width > 600 ? 4 : 3
                        let gridItems = Array(repeating: GridItem(.flexible(), spacing: 16), count: columnsCount)
                        
                        ScrollView {
                            LazyVGrid(columns: gridItems, spacing: 16) {
                                ForEach(folders, id: \.self) { folder in

                                        FolderItemView(folder: folder, viewModel: FolderViewModel(context: context))

                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Folders")
            .toolbar {
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

