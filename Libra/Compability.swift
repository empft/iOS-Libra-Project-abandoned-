//
//  Compability.swift
//  Libra
//
//  Created by Catalina on 20/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

// Compability Check, may be scrapped because it might not work with canvas
import Foundation
import CoreHaptics

class Compability {
    static let shared = Compability()
    
    var haptics: Bool = false
    
    init() {
        // Haptics check
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        haptics = hapticCapability.supportsHaptics
        
        //
    }
}
