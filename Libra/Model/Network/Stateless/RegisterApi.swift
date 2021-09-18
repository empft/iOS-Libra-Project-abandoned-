//
//  RegisterApi.swift
//  Libra
//
//  Created by Big Sur on 15/9/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import Combine

struct RegisterApi {
    let baseURL: URL
    let session: URLSession
    
    func exist(username: String) -> AnyPublisher<Bool, Error> {
        var urlComponents = URLComponents(string: baseURL.absoluteString)!
        urlComponents.path = "users/exist"
        urlComponents.queryItems = [
            URLQueryItem(name: "username", value: username)
        ]
        
        var url = URLRequest(url: urlComponents.url!)
        url.httpMethod = "GET"
        
        return session.errorHandledPublisher(for: url, using: Bool.self)
    }
    
    func register(username: String, displayName: String, password: String, email: String) -> AnyPublisher<HTTPURLResponse, Error> {
        var url = URLRequest(url: URL(string: "users/register", relativeTo: baseURL)!)
        
        let data : Data = "username=\(username)&displayName=\(displayName)&password=\(password)&email=\(email)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .map { (_, response) in
                return response
            }.eraseToAnyPublisher()
    }
    
    func createInvitation(email: String) -> AnyPublisher<Never, Error> {
        var url = URLRequest(url: URL(string: "users/invitation", relativeTo: baseURL)!)
        
        let data : Data = "email=\(email)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .ignoreOutput()
            .eraseToAnyPublisher()
    }
    
    func registerWithInvitation(username: String, displayName: String, password: String, email: String, invitationEmail: String, invitationCode: String) -> AnyPublisher<HTTPURLResponse, Error> {
        var url = URLRequest(url: URL(string: "users/register-with-invitation", relativeTo: baseURL)!)
        
        let data : Data = "username=\(username)&displayName=\(displayName)&password=\(password)&email=\(email)&invitationEmail=\(invitationEmail)&invitationCode=\(invitationCode)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .map { (_, response) in
                return response
            }.eraseToAnyPublisher()
    }
}
