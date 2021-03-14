//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Catalina on 16/07/2020.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var test: NSDecimalNumber?

}
