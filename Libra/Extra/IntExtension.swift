//
//  IntExtension.swift
//  Libra
//
//  Created by Catalina on 5/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

/// Time
extension Int {
    var toTime: String {
        
        let (h,m,s) = (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        
        let hour = h < 10 ? "0\(h)" : "\(h)"
        let min = m < 10 ? "0\(m)" : "\(m)"
        let sec = s < 10 ? "0\(s)" : "\(s)"
        
        return h == 0 ? "\(min):\(sec)" : "\(hour):\(min):\(sec)"
    }
}
