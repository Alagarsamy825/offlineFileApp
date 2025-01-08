//
//  Folder+CoreDataProperties.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 08/01/25.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var creation: Date?
    @NSManaged public var files: [String]?

}

extension Folder : Identifiable {

}
