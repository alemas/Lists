//
//  PersistentContainer.swift
//  Lists
//
//  Created by Mateus Reckziegel on 11/05/21.
//

import UIKit
import CoreData

class PersistentContainer: NSPersistentContainer {
    
    init(name: String) {
        
        guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        super.init(name: name, managedObjectModel: model)
        
        self.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
    }
    
    func fetch(fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> [NSManagedObject] {
        do {
            let result = try self.viewContext.fetch(fetchRequest) as! [NSManagedObject]
//            for data in result {
//                print(data.value(forKey: "name") as! String)
//                print(data.value(forKey: "creationDate") as! Date)
//            }
            return result
        } catch {
            fatalError("Unable to fetch request: \(error)")
        }
    }
    
    func fetchById(id: NSManagedObjectID) -> NSManagedObject {
        return self.viewContext.object(with: id)
    }
    
    func delete(object: NSManagedObject) {
        self.viewContext.delete(object)
    }
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
       let context = backgroundContext ?? viewContext
       guard context.hasChanges else { return }
       do {
           try context.save()
       } catch let error as NSError {
           print("Error: \(error), \(error.userInfo)")
       }
   }
}
