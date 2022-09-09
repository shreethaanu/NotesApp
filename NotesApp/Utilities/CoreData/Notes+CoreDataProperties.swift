//
//  Notes+CoreDataProperties.swift
//  NotesApp
//
//  Created by ShreeThaanu on 09/09/22.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var archived: String?
    @NSManaged public var body: String?
    @NSManaged public var created_time: Int64
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?

}

extension Notes : Identifiable {

}
