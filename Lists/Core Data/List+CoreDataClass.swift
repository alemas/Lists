//
//  List+CoreDataClass.swift
//  Lists
//
//  Created by Mateus Reckziegel on 15/05/21.
//
//

import Foundation
import CoreData

@objc(List)
public class List: NSManagedObject {
    
    public var itemsArray: [ListItem] {
        let set = items ?? []
        return set.sorted { item1, item2 in
            return item1.creationDate!.timeIntervalSince1970 < item2.creationDate!.timeIntervalSince1970
        }
    }
}
