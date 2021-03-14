//
//  StringExtension.swift
//  Libra
//
//  Created by Catalina on 18/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//
import SwiftUI

/// Font Size
extension String {
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
}

/// Regex
extension String {
    func matches(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    var isEmail: Bool {
        // Copied from Android EMAIL_ADDRESS Pattern
        // Deprecated because unicode email exists
        // Switched to simple check of @ symbol
        /*
        let pattern = "^[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+$"
        */
        
        return self.filter({ $0 == "@" }).count == 1
    }
    
    var isOTP: Bool {
        let pattern = "^[0-9]{6}$"
        return matches(pattern: pattern)
    }
}

