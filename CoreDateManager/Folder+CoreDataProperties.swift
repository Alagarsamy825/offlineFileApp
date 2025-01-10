//
//  Folder+CoreDataProperties.swift
//  offlineFileApp
//
//  Created by Elavazhagan on 10/01/25.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var color: String?
    @NSManaged public var creation: Date?
    @NSManaged public var favourite: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var files: NSSet?

}

// MARK: Generated accessors for files
extension Folder {

    @objc(addFilesObject:)
    @NSManaged public func addToFiles(_ value: File)

    @objc(removeFilesObject:)
    @NSManaged public func removeFromFiles(_ value: File)

    @objc(addFiles:)
    @NSManaged public func addToFiles(_ values: NSSet)

    @objc(removeFiles:)
    @NSManaged public func removeFromFiles(_ values: NSSet)

}

extension Folder : Identifiable {

}
