//
//  ListItem+CoreDataProperties.swift
//  Lists
//
//  Created by Mateus Reckziegel on 15/05/21.
//
//

import Foundation
import CoreData


extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var isDone: Bool
    @NSManaged public var itemDescription: String?
    @NSManaged public var list: List?

}

extension ListItem : Identifiable {

}
