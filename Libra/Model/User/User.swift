//
//  UserFacade.swift
//  Libra
//
//  Created by Catalina on 12/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit

// Responsible for managing everything that is tied to a user
// Session Key in Keychain
// login state in UserDefaults
// UserLoginHelper manages session key and login state
// Cache and Profile/Config in CoreData
class User {
    // Hold session Key and login state
    internal var appSession: AppSession = AppSession()
    // Hold other informations
    internal var userStorage: UserStorage = UserStorage()
    
    var displayName: String? {
        userStorage.retrieve.displayName
    }
    
    var profilePicture: UIImage? {
        if let imageData = userStorage.retrieve.profilePicture {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    /// Remove the user account and cleanup
    func logout() {
        userStorage.void()
        appSession.appLogout()
    }
}
