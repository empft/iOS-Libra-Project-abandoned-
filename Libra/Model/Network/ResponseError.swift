//
//  ResponseError.swift
//  Libra
//
//  Created by Big Sur on 17/9/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case vanilla(code: Int, message: String)
    case unexpected(String)
}

extension ResponseError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .vanilla(let code, let message): return "Response error: \(code), \(message)"
            case .unexpected(let message): return "Response error: \(message)"
        }
    }
}

struct LabelledHTTPError: Decodable {
    var code: Int
    var message: String
}
