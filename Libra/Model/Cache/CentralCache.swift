//
//  CentralCache.swift
//  Libra
//
//  Created by Big Sur on 27/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

struct CentralCache {
    private let multicast = MulticastDelegate<CentralCacheDelegate>()
    
    init(_ delegates: [CentralCacheDelegate]) {
        delegates.forEach(multicast.add)
    }
    
    
    
    
}

enum CacheFrequency {
    case Manual
}
