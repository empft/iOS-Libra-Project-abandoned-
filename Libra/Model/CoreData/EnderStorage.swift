//
//  CoreData.swift
//  Libra
//
//  Created by Catalina on 16/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import CoreData

/// Core Data Base Class
class EnderStorage {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Libra")
        container.loadPersistentStores { _ , error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    /// Retrieve managed object context and *you* need to manually inject it to a view, use this with fetchRequest
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    internal func save() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
              try context.save()
            } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

