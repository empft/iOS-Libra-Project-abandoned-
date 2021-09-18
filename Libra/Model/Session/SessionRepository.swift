//
//  SessionRepository.swift
//  Libra
//
//  Created by Big Sur on 18/9/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

protocol SessionRepository {
    associatedtype T
    
    func getAll() -> ([T]?, Int?)
    func setAll(values: [T]?, index: Int?)
    
    func get() -> T?
    func delete()
    func exist() -> Bool
}
