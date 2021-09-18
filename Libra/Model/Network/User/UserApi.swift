//
//  UserApi.swift
//  Libra
//
//  Created by Catalina on 13/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine

// For any request sent using user cookie
class UserApi {
    private let baseUrl = URL(string: Constants.Url.userUrl)!
    
    init(user: User) throws {
        let cookie = HTTPCookie(properties: [
            .domain: baseUrl,
            .path: "/",
            .name: Constants.Cookies.userSession,
            .value: try user.appSession.getSessionKey(),
            .secure: "TRUE",
            .discard: "TRUE"
        ])!
        
        HTTPCookieStorage.shared.setCookie(cookie)
    }
    
    /*
    func getProfile() -> AnyPublisher<Any, Error> {
        
    }
    */
    
    
    deinit {
        HTTPCookieStorage.shared.cookies(for: baseUrl)?.forEach(HTTPCookieStorage.shared.deleteCookie)
    }
    
}


