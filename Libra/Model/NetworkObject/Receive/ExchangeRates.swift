//
//  ExchangeRate.swift
//  Libra
//
//  Created by Big Sur on 23/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

struct ExchangeRate: Decodable {
    let currency: String
    let value: Decimal
}

struct ExchangeRateJson: Decodable, JsonBase {
    var success: Bool
    var data: [ExchangeRate]
    var message: String?
}
