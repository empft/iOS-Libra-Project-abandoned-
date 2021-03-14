//
//  UserError.swift
//  Libra
//
//  Created by Catalina on 14/9/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

enum UserError: Error {
    /// throw this error when key is missing or invalid and need to restart the login
    case KeyError(String)
    
    
}
