//
//  UserChest.swift
//  Libra
//
//  Created by Catalina on 29/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import CoreData

// Can refactor this to generic for singleton core data entity pattern, however I don't think any other data sources will use this pattern
class UserStorage: EnderStorage {
    
    // Create a fetched entity that is optional because the fetching process is failable
    // _user is backing property
    private var _user: UserProfile? = nil
    private var user: UserProfile? {
        if _user == nil {
            _user = fetch()
        }
        return _user
    }
    
    private let request: NSFetchRequest<NSFetchRequestResult> = UserProfile.fetchRequest()
    
    /// return either an empty user profile or a configured user profile, enforce single user entity pattern
    private func fetch() -> UserProfile? {
        var fetched = [UserProfile]()
        
        do {
            fetched = try context.fetch(request) as! [UserProfile]
        } catch {
            print("Fetch UserProfile failed")
            return nil
        }
        
        switch fetched.count {
        case 1:
            return fetched.first!
        case 0:
            return UserProfile(context: context)
        default:
            fatalError("Error in UserStorage when fetching entity")
        }
    }
    
    /// Read-Only Retrieval
    var retrieve: UserProfile {
        return fetch() ?? UserProfile()
    }
    
    /// Update attributes
    func update(profile: UserProfile) {
        guard let original = user else { return }
        
        original.shallowCopy(from: profile)
        
        save()
    }
    
    /// Delete everything
    func void() {
        _  = NSBatchDeleteRequest(fetchRequest: request)
    }
    
    
    
}

