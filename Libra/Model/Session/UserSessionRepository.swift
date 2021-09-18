//
//  UserSessionRepository.swift
//  Libra
//
//  Created by Big Sur on 18/9/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation
import os

struct UserSessionRepository: SessionRepository {
    func get() -> SessionToken? {
        let (all, index) = self.getAll()
        guard let index = index else {
            return nil
        }
        guard let all = all else {
            self.setIndex(value: nil)
            return nil
        }
        
        guard let item = all[safe: index] else {
            self.setIndex(value: nil)
            return nil
        }
        return item
    }
    
    func delete() {
        let (all, index) = self.getAll()
        guard let index = index else {
            return
        }
        guard var all = all else {
            self.setIndex(value: nil)
            return
        }
        
        guard all[safe: index] != nil else {
            self.setIndex(value: nil)
            return
        }
        
        all.remove(at: index)
        self.setAll(values: all, index: nil)
    }
    
    func exist() -> Bool {
        return self.getIndex() != nil
    }
    
    func getAll() -> ([SessionToken]?, Int?) {
        let index = getIndex()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConstant.LocalAppService.service,
            kSecAttrAccount as String: KeychainConstant.LocalAppService.userSession,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        let logger = Logger()
        
        var data: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        guard status != errSecItemNotFound else {
            return (nil, index)
        }
        
        guard status == errSecSuccess else {
            logger.error("Fail to access keychain: OSStatus \(status)")
            return (nil, nil)
        }
        
        guard let existingItem = data as? [String: Any],
              let encoded = existingItem[kSecValueData as String] as? Data
        else {
            logger.error("Fail to process \(data.debugDescription)")
            return (nil, nil)
        }
        
        do {
            return (try JSONDecoder().decode([SessionToken].self, from: encoded), index)
        } catch {
            logger.error("Fail to decode json: \(error)")
            return (nil, nil)
        }
    }
    
    func setAll(values: [SessionToken]?, index: Int?) {
        guard values != nil && index != nil && (index! < 0 || index! >= values!.count) else {
            assertionFailure("Index \(index!) is outside of array \(values!)")
        }
        
        do {
            let encoded = try JSONEncoder().encode(values)
            
            let _: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeychainConstant.LocalAppService.service,
                kSecAttrAccount as String: KeychainConstant.LocalAppService.userSession,
                kSecValueData as String: encoded
            ]
            
        } catch {
            
        }
        
        let (all, _) = self.getAll()
        if all == nil {
            
        } else {
            
        }
    }
    
    private func setIndex(value: Int?) {
        if let index = value {
            // Does not work before ios 10 if set nil
            UserDefaults.standard.set(index, forKey: UDConstant.userSessionActive)
        } else {
            UserDefaults.standard.removeObject(forKey: UDConstant.userSessionActive)
        }
    }
    
    private func getIndex() -> Int? {
        return UserDefaults.standard.object(forKey: UDConstant.userSessionActive) as? Int
    }
}

struct SessionToken: Codable {
    let name: String
    let token: String
}
