//
//  StatelessApi.swift
//  Libra
//
//  Created by Catalina on 13/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine

struct LoginApi {
    let baseURL: URL
    let session: URLSession
    
    func login(username: String, password: String) -> AnyPublisher<HTTPURLResponse, Error> {      
        var url = URLRequest(url: URL(string: "users/login", relativeTo: baseURL)!)
        
        let data : Data = "username=\(username)&password=\(password)".data(using: .utf8)!
        url.httpMethod = "POST"
        url.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        url.httpBody = data
        
        return session.errorHandledPublisher(for: url)
            .map { (_, response) in
                return response
            }.eraseToAnyPublisher()
    }
}

let cookies = HTTPCookie.cookies(withResponseHeaderFields: response.allHeaderFields as! [String: String], for: response.url!)
guard let cookie = cookies.first(where: { (cookie) in
    cookie.name == NetworkConstant.userCookie
}) else {
    throw ResponseError.unexpected("User session cookie not found")
}
return cookie.value
