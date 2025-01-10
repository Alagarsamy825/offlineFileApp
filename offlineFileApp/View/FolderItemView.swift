//
//  FolderItemView.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 10/01/25.
//

import Foundation
import SwiftUI


struct FolderItemView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var folder: Folder
    @ObservedObject var viewModel: FolderViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Image(systemName: "folder.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color(hex: folder.color!))
                Text(folder.name!)
                    .font(.caption)
                    .foregroundColor(.primary)
                Text(folder.creation ?? Date(), style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            //            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
            
            
            Button(action: toggleFavourite) {
                Image(systemName: folder.favourite ? "heart.fill" : "heart")
                    .foregroundColor(folder.favourite ? .red : .gray)
                    .padding(8)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 2)
                
            }
            .frame(width: 8, height: 8)
            .opacity(0.8)
            .offset(x: -15, y: 15)
        }
    }
    private func toggleFavourite() {
        viewModel.updateFavouriteStatus(for: folder.name!, to: !folder.favourite)
    }
}
