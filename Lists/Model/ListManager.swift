//
//  ListManager.swift
//  Lists
//
//  Created by Mateus Reckziegel on 13/05/21.
//

import UIKit
import CoreData

class ListManager {
    
    static private var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    static func newList(name: String) {
        if let entity = NSEntityDescription.entity(forEntityName: "List", in: persistentContainer.viewContext) {
            let list = List(entity: entity, insertInto: persistentContainer.viewContext)
            list.name = name
            list.creationDate = Date()
        }
    }
    
    static func newListItem(list: List, itemDescription: String) {
        if let entity = NSEntityDescription.entity(forEntityName: "ListItem", in: persistentContainer.viewContext) {
            let item = ListItem(entity: entity, insertInto: persistentContainer.viewContext)
            item.itemDescription = itemDescription
            item.list = list
            item.creationDate = Date()
        }
    }
    
    static func editList(list: List, name: String?) {
        if let name = name { list.name = name }
    }
    
    static func deleteList(list: List) {
        for item in list.itemsArray {
            persistentContainer.delete(object: item)
        }
        persistentContainer.delete(object: list)
    }
    
    static func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        persistentContainer.saveContext(backgroundContext: backgroundContext)
    }
    
    static func retrieveLists() -> Array<List>  {
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return Array(persistentContainer.fetch(fetchRequest: fetchRequest).compactMap({ object in
            return object as? List
        }))
    }
}
