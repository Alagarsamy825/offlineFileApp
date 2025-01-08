//
//  ContentView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 08/01/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isAddingFolder = false
    @State private var folders: [(name: String, color: Color, creation: Date)] = []

    var body: some View {
        NavigationView {
            VStack {
                if folders.isEmpty {
                    Text("No folders available")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    // Dynamic grid layout based on screen width
                    GeometryReader { geometry in
                        let columnsCount = geometry.size.width > 600 ? 4 : 3 // Adjust number of columns for larger screens
                        
                        ScrollView {
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columnsCount), spacing: 20) {
                                ForEach(folders, id: \.name) { folder in
                                    VStack {
                                        // Folder Icon with selected color as tint
                                        Image(systemName: "folder.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .foregroundColor(folder.color) // Apply the selected color as tint
                                        Text(folder.name)
                                            .font(.caption)
                                            .foregroundColor(.primary)
                                        Text(folder.creation, style: .date)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Folders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddingFolder = true
                    }) {
                        Image(systemName: "folder.badge.plus")
                    }
                }
            }
            .sheet(isPresented: $isAddingFolder) {
                AddFolderView(isPresented: $isAddingFolder, folders: $folders)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Adapt for iPad as well
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
