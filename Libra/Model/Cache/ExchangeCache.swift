//
//  ExchangeCache.swift
//  Libra
//
//  Created by Big Sur on 27/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import Combine

struct ExchangeCache: CentralCacheDelegate {
    private let repository = ExchangeRepository()
    
    let frequency: CacheFrequency = .Manual
    
    func updateCache(cancellable: inout Set<AnyCancellable>) {
        repository.getRemoteRates()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Fetch exchange rates for caching succeeded.")
                case .failure(let error):
                    print("Fetch exchange rates for caching failed:", error.localizedDescription)
                }
                
            }, receiveValue: { rates in
                repository.setLocalRates(rates: rates)
            }).store(in: &cancellable)
    }
}
