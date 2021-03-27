//
//  Bool.swift
//  Libra
//
//  Created by Catalina on 29/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct BoolJson: Decodable, JsonBase {
    var success: Bool
    var data: Bool
    var message: String?
}
