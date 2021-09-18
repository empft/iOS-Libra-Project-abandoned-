//
//  LoginRepository.swift
//  Libra
//
//  Created by Catalina on 9/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine

// Handle Login/Registration Process
struct LoginRepository {
    private let api = 

    /// Register an account and return whether registration is successful
    func register(form: RegistrationForm) -> AnyPublisher<(data: Bool,response: URLResponse),Error> {
        
        return api.register(form: form)
    }
    
    /// Login and return whether login is successful
    func login(username: String, password: String) -> AnyPublisher<(data: Bool,response: URLResponse),Error> {
        return api.login(username: username, password: password)
    }
    
    
    
    func requestCode(email: String) -> AnyPublisher<[Error], Never> {
        return api.requestCode(email: email)
    }
    
    func usernameExists(username: String) -> AnyPublisher<Bool,Error> {
        return api.usernameExists(username: username)
    }
    
    
    
}
