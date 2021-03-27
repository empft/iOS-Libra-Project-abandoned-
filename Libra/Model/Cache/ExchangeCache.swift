//
//  ExchangeCache.swift
//  Libra
//
//  Created by Big Sur on 27/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

struct ExchangeCache: CentralCacheDelegate {
    private let repository = ExchangeRepository()
    
    let frequency: CacheFrequency = .Manual
    
    func updateCache() {
        <#code#>
    }
}
