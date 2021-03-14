//
//  UserRepository.swift
//  Libra
//
//  Created by Catalina on 12/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class UserRepository {
    // local Storage
    let currentUser: User
    // Remote Storage
    let userApi: UserApi
    
    init() throws {
        // fetch the logged in user
        currentUser = User()
        // try to initialize api with current user session key, relogin if fail
        userApi = try UserApi(user: currentUser)
    }
    
    
    
    
    
    
    
}
