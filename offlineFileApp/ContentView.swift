//
//  ContentView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 08/01/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Folder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Folder.creation, ascending: true)]
    ) private var folders: FetchedResults<Folder>
    
    @State private var isAddingFolder = false
    
    var body: some View {
        
            VStack {
                FolderGridView(viewModel: FolderViewModel(context: viewContext))
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
}
