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

    var body: some View {
        List {
            ForEach(folder.files?.allObjects as? [File] ?? [], id: \.self) { file in
                VStack(alignment: .leading) {
                    Text(file.name ?? "Unnamed File")
                        .font(.headline)
                    Text("Created on \(file.creationDate ?? Date(), formatter: dateFormatter)")
                        .font(.subheadline)
                }
            }
        }
        .navigationTitle(folder.name ?? "Folder")
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
