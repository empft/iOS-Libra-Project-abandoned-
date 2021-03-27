//
//  Currency.swift
//  Libra
//
//  Created by Big Sur on 20/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

enum CurrencyType: String {
    case Libra = "Libra"
    case USD = "USD"
    case EUR = "EUR"
    case GBP = "GBP"
    case MYR = "MYR"
    case SGD = "SGD"
}

/**
 Main class for handling currency exchange
 */
struct CurrencyExchange {
    private let repo = ExchangeRepository()
    private var rates: LibraRates {
        repo.getExchangeRates()
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .finished:
                        
                    case .failure(let error):
                }
            }, receiveValue: <#T##((LibraRates) -> Void)##((LibraRates) -> Void)##(LibraRates) -> Void#>)
    }
    
    private var cacheRates: LibraRates {
        
    }
    
    private func exchange(rates: LibraRates, amount: Decimal, from input: CurrencyType, to output: CurrencyType) -> Decimal {
        return amount * rates.rate(of: output) / rates.rate(of: input)
    }
    
    func exchange(from libra: Libra, to type: CurrencyType) -> Decimal {
        
        return libra.amount * rates.rate(of: type)
    }
    
    func exchange(amount: Decimal, from input: CurrencyType, to output: CurrencyType) -> Decimal {
        return amount * rates.rate(of: output) / rates.rate(of: input)
    }
    
    func offlineExchange(from libra: Libra, to type: CurrencyType) -> Decimal {
        
    }
}

/**
 Model for exchange rates
 */
struct LibraRates {
    private let rates: Dictionary<String, Decimal>
    	let lastUpdated: Date
  
    init(from retrieveRates: [ExchangeRate]) {
        rates = Dictionary(uniqueKeysWithValues: retrieveRates.map{ ($0.currency, $0.value) })
        
        // Add Libra with exchange rate = 1
        rates[CurrencyType.Libra.rawValue] = 1
        
        lastUpdated = Date()
    }
    
    func rate(of type: CurrencyType) -> Decimal {
        return rates[type.rawValue]!
    }
}
