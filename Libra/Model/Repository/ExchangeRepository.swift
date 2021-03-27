//
//  ExchangeRepository.swift
//  Libra
//
//  Created by Big Sur on 22/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import Combine

struct ExchangeRepository {
    private let api = StatelessApi.shared
    private let appDelegate = 
    
    func getExchangeRates() -> AnyPublisher<LibraRates, Error> {
        api.getExchangeRates()
            .subscribe(on: DispatchQueue.global(qos: .unspecified))
            .map { rates in
                return LibraRates(from: rates)
            }.eraseToAnyPublisher()
    }
    
    func getCacheRates() -> LibraRates {
    
    }
    
}
