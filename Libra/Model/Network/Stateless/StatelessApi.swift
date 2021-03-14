//
//  StatelessApi.swift
//  Libra
//
//  Created by Catalina on 13/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine

final class StatelessApi {
    static let shared = StatelessApi()
    
    private let baseUrl = URL(string: Constants.Url.baseUrl)!
    
    func login(username: String, password: String) -> AnyPublisher<(data: Bool,response: URLResponse),Error> {
        
        
        var url = URLRequest(url: baseUrl)
        
        let params = ["username":username, "password": password]
        url.httpMethod = "POST"
        url.addValue("application/json", forHTTPHeaderField: "Content-Type")
        url.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        return URLSession.shared.getBoolResponse(for: url)
    }
    
    func requestCode(email: String) -> AnyPublisher<[Error], Never> {
        var url = URLRequest(url: baseUrl)
        url.httpMethod = "POST"
        return URLSession.shared.sendRequest(for: url)
    }
    
    func usernameExists(username: String) -> AnyPublisher<Bool,Error> {
        var url = URLRequest(url: baseUrl)
        url.httpMethod = "GET"
        return URLSession.shared.getBool(for: url)
    }
    
    func register(form: RegistrationForm) -> AnyPublisher<(data: Bool,response: URLResponse),Error> {
        var url = URLRequest(url: baseUrl)
        url.httpMethod = "POST"
        return URLSession.shared.getBoolResponse(for: url)
    }

    
    
    
}
