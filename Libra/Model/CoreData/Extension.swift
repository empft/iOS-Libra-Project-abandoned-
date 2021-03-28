//
//  Extension.swift
//  Libra
//
//  Created by Catalina on 10/9/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    /// Copy all the non empty attributes from source to current object
    func shallowCopy<T: NSManagedObject>(from source: T) {
        assert(self is T, "Cannot copy from entity of different type")
        
        let attributes = entity.attributesByName
        
        for (key, _) in attributes {
            let value = source.value(forKey: key)
            
            if value != nil {
                self.setValue(value!, forKey: key)
            }
        }
    }
}

extension NSManagedObjectContext {
    public func newPrivateChildContext() -> NSManagedObjectContext{
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = self
        return moc
    }
    
    public func newUIChildContext() -> NSManagedObjectContext{
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.parent = self
        return moc
    }    
}

