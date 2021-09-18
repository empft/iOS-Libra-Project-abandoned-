//
//  RecoveryApi.swift
//  Libra
//
//  Created by Big Sur on 15/9/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import Combine

struct RecoveryApi {
    let baseURL: URL
    let session: URLSession
    
    func forgetUsername(email: String) -> AnyPublisher<Never, Error> {
        var url = URLRequest(url: URL(string: "users/forget-username", relativeTo: baseURL)!)
        
        let data : Data = "email=\(email)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .ignoreOutput()
            .eraseToAnyPublisher()
    }
    
    func forgetPassword(username: String, email: String) -> AnyPublisher<Never, Error> {
        var url = URLRequest(url: URL(string: "users/forget-password", relativeTo: baseURL)!)
        
        let data : Data = "username=\(username)&email=\(email)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .ignoreOutput()
            .eraseToAnyPublisher()
    }
    
    func resetPassword(token: String, password: String) -> AnyPublisher<Never, Error> {
        var url = URLRequest(url: URL(string: "users/reset-password", relativeTo: baseURL)!)
        
        let data : Data = "token=\(token)&password=\(password)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .ignoreOutput()
            .eraseToAnyPublisher()
    }
}
