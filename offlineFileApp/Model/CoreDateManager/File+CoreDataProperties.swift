//
//  File+CoreDataProperties.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 14/01/25.
//
//

import Foundation
import CoreData


extension File {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<File> {
        return NSFetchRequest<File>(entityName: "File")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var data: Data?
    @NSManaged public var name: String?
    @NSManaged public var folder: Folder?

}

extension File : Identifiable {

}
