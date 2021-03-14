//
//  LoginProtocol.swift
//  Libra
//
//  Created by Catalina on 27/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

final class AppSession {
    let sessionKey: SessionKey
    
    init() {
        sessionKey = SessionKey()
    }

    private var loginState: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaults.loginState)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaults.loginState)
        }
    }
    
    func getSessionKey() throws -> String {
        guard let key = sessionKey.get() else {
            throw UserError.KeyError("Cannot Retrieve User Session Key")
        }
        
        return key
    }
    
    /// Check whether the user has logged in this application
    func isLoggedIn() -> Bool {
        return loginState
    }
    
    /// Login within this app after verifying use through api
    func appLogin(key: String) {
        sessionKey.set(key: key)
        
        loginState = true
    }
    
    /// Logout within this app
    func appLogout() {
        sessionKey.delete()
        
        loginState = false
    }
    
}
