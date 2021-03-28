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
 Model for exchange rates
 */
struct LibraRates {
    private var rates: Dictionary<String, Decimal>
    let lastUpdated: Date
  
    /**
        Provide the ExchangeRateDTO and last updated date, if no date is provided, the current date is used.
     */
    init(from retrieveRates: ExchangeRateDTO, since lastUpdatedDate: Date = Date()) {
        rates = Dictionary(uniqueKeysWithValues: retrieveRates.map{ ($0.currency, $0.value) })
        
        // Add Libra with exchange rate = 1
        rates[CurrencyType.Libra.rawValue] = 1
        
        self.lastUpdated = lastUpdatedDate
    }
    
    /**
        Retrieve from local database, it is assumed that all rates are updated at the same time
     */
    init(from retrieveRates: [ExchangeRate]) {
        rates = Dictionary(uniqueKeysWithValues: retrieveRates.map{ ($0.currency!, $0.value!.decimalValue) })
        
        // Add Libra with exchange rate = 1
        rates[CurrencyType.Libra.rawValue] = 1
        
        self.lastUpdated = (retrieveRates.first!.lastUpdated)!
    }
    
    func toDTO() -> ExchangeRateDTO {
        var dto = ExchangeRateDTO()
        rates.forEach {
            dto.append(ExchangeRateItem(currency: $0.key, value: $0.value))
        }
        return dto
    }
    
    func rate(of type: CurrencyType) -> Decimal {
        return rates[type.rawValue]!
    }
}
