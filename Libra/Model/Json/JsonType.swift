//
//  JsonType.swift
//  Libra
//
//  Created by Catalina on 22/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

protocol JsonBase {
    associatedtype ResultType
    var success: Bool { get }
    var data: ResultType { get }
    var message: String? { get }
}

struct JsonType: Decodable, JsonBase {
    var success: Bool
    var data: Any?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case success, message
    }
}
