//
//  CoreHaptics.swift
//  Libra
//
//  Created by Catalina on 20/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import CoreHaptics
import AudioToolbox

struct Haptics {

    static func vibrate() {
        
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        
        // Haptic engine is not supported on some devices
        /*
        let hapticDict = [
            CHHapticPattern.Key.pattern: [
                [CHHapticPattern.Key.event: [CHHapticPattern.Key.eventType: CHHapticEvent.EventType.hapticTransient,
                      CHHapticPattern.Key.time: 0.001,
                      CHHapticPattern.Key.eventDuration: 1.0] // End of first event
                ] // End of first dictionary entry in the array
            ] // End of array
        ] // End of haptic dictionary

        do {
            let engine = try CHHapticEngine()
            try engine.start()
            
            let pattern = try CHHapticPattern(dictionary: hapticDict)
            let player = try engine.makePlayer(with: pattern)
            
            engine.start(completionHandler:nil)
            try player.start(atTime: 0)
            engine.stop(completionHandler: nil)
            
        } catch let error {
            print("Haptic Error: \(error)")
            return
        }
        */
        
        

    }
}
