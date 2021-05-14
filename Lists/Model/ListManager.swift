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
            
            persistentContainer.saveContext()
        }
    }
    
    static func newListItem() {
        
    }
    
    static func retrieveLists() -> Array<List>  {
        let fetchRequest =  NSFetchRequest<NSFetchRequestResult>(entityName: "List")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return Array(persistentContainer.fetch(fetchRequest: fetchRequest).compactMap({ object in
            return object as? List
        }))
    }
    
}
