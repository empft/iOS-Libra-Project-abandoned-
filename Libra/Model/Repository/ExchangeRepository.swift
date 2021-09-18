//
//  ExchangeRepository.swift
//  Libra
//
//  Created by Big Sur on 22/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import CoreData
import Combine

struct ExchangeRepository {
    private let api = LoginApi(baseURL: <#URL#>, session: <#URLSession#>)
    private let storage = EnderStorage.shared.container.viewContext
    private let request: NSFetchRequest = ExchangeRate.fetchRequest()
    
    func getRemoteRates() -> AnyPublisher<LibraRates, Error> {
        api.getExchangeRates()
            .subscribe(on: DispatchQueue.global(qos: .unspecified))
            .map { rates in
                return LibraRates(from: rates)
            }.eraseToAnyPublisher()
    }
    
    /**
        Get cached exchange rates on UI thread
     */
    func getLocalRates() -> LibraRates {
        let rates = try! storage.fetch(request)
        return LibraRates.init(from: rates)
    }
    
    func setLocalRates(rates: LibraRates) {
        let child = storage.newPrivateChildContext()
        child.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        child.perform {
            rates.toDTO().forEach { item in
                let exchangeRate = ExchangeRate(context: child)
                exchangeRate.currency = item.currency
                exchangeRate.value = NSDecimalNumber(decimal: item.value)
            }
            
            try! child.save()
        }
    }
    
}


