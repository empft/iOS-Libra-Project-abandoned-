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

    /// Register an account and return whether registration is successful
    func register(form: RegistrationForm) -> AnyPublisher<(data: Bool,response: URLResponse),Error> {
        
        return StatelessApi.shared.register(form: form)
    }
    
    /// Login and return whether login is successful
    func login(username: String, password: String) -> AnyPublisher<(data: Bool,response: URLResponse),Error> {
        return StatelessApi.shared.login(username: username, password: password)
    }
    
    
    
    func requestCode(email: String) -> AnyPublisher<[Error], Never> {
        return StatelessApi.shared.requestCode(email: email)
    }
    
    func usernameExists(username: String) -> AnyPublisher<Bool,Error> {
        return StatelessApi.shared.usernameExists(username: username)
    }
    
    
    
}
