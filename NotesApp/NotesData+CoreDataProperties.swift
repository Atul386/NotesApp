//
//  NotesData+CoreDataProperties.swift
//  NotesApp
//
//  Created by Vishal Kamble on 06/05/24.
//
//

import Foundation
import CoreData


extension NotesData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesData> {
        return NSFetchRequest<NotesData>(entityName: "NotesData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var date: String?
    @NSManaged public var priority: String?

}

extension NotesData : Identifiable {

}
