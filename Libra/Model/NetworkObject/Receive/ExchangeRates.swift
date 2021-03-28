//
//  ExchangeRate.swift
//  Libra
//
//  Created by Big Sur on 23/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

typealias ExchangeRateDTO = [ExchangeRateItem]

struct ExchangeRateItem: Decodable {
    let currency: String
    let value: Decimal
}

struct ExchangeRateJson: Decodable, JsonBase {
    var success: Bool
    var data: ExchangeRateDTO
    var message: String?
}
