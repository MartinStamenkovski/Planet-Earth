//
//  NSPersist.swift
//  PEDatabase
//
//  Created by Martin Stamenkovski on 11.12.20.
//

import CoreData

public final class NSPersist: NSPersistentContainer {
    
    public static let shared: NSPersist = {
       let database = NSPersist(name: "PEDatabase")
        database.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        try? database.viewContext.setQueryGenerationFrom(.current)
        database.viewContext.automaticallyMergesChangesFromParent = true
        database.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        return database
    }()
    
    public func save(context: NSManagedObjectContext) {
        context.perform {
            guard context.hasChanges
            else { return }
            
            do {
                try context.save()
            } catch {
                #if DEBUG
                print("Saving context failed: \(error)")
                #endif
            }
        }
    }
}
