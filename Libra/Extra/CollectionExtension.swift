//
//  CollectionExtension.swift
//  Libra
//
//  Created by Big Sur on 18/9/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
