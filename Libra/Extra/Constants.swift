//
//  Constants.swift
//  Libra
//
//  Created by Catalina on 17/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Url {
        /// Stateless Network Request
        static let baseUrl = ""
        
        /// Authenticated User
        static let userUrl = ""
        
    }
    
    struct UserDefaults {
        /// Store the login State
        static let loginState = "userLogin"
        
        
    }
    
    /// Store Key of cookies
    struct Cookies {
        /// Authentication Token for logged in user
        static let userSession = "user"
    }
    
    
    
    
    
    
    
    
    
    /// Span of size of Map Shown
    static let coordinateDelta = 0.2

    /// Time taken for loading arrow to rotate 360 degrees
    static let ROTATION_TIME: Double = 1.5
    
    /// Back Button Arrow/ Chevron
    static let CHEVRON = "chevron.left"
    
    /// An arbitrary value, must be discarded
    static let ARBITRARY = 0
}
