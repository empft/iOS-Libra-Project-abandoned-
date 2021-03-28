//
//  CacheDelegate.swift
//  Libra
//
//  Created by Big Sur on 27/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import Combine

protocol CentralCacheDelegate {
    var frequency: CacheFrequency { get }
    
    /**
     Store a reference using anycancellable
     */
    func updateCache(cancellable: inout Set<AnyCancellable>)
}
