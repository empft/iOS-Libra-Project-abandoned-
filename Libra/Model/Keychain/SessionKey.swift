//
//  SessionKey.swift
//  Libra
//
//  Created by Catalina on 18/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Security

final class SessionKey: QuantumKey {
    let keychain: QuantumKeychain = QuantumKeychain()
    var query = QuantumKeychain.Builder()
        .setTag(.user)
        .setLabel("Session Key")
        .build()
        
    private func checkIfExists() -> Bool {
        return keychain.quickGet(query: query) != nil
    }
    
    func get() -> String? {
        var key: Data?
        
        key = keychain.quickGet(query: query)
    
        return key != nil ? String(decoding: key!, as: UTF8.self) : nil
    }
    
    func set(key: String) {
        let item = key.data(using: .utf8)!
        let attr = QuantumKeychain.Builder()
            .setValue(item)
            .build()
        
        do {
            if checkIfExists() {
                try keychain.updateItem(query: query, attributes: attr)
            } else {
                try keychain.storeItem(item: item, query: query)
            }
        } catch(let error) {
            print(error)
        }
    }
    
    func delete() {
        try? keychain.deleteItem(query: query)
    }
}
