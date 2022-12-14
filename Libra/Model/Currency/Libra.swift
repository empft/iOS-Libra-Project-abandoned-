//
//  Libra.swift
//  Libra
//
//  Created by Big Sur on 22/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

struct Libra: Comparable {
    let amount: Decimal
    
    init(from double: Double) {
        amount = NSNumber(floatLiteral: double).decimalValue
    }
    
    static func < (lhs: Libra, rhs: Libra) -> Bool {
        lhs.amount == rhs.amount
    }
}
