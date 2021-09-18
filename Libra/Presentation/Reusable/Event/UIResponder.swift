//
//  UIResponder.swift
//  Libra
//
//  Created by Catalina on 16/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

extension UIApplication {
    
    // Lower Keyboard
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
