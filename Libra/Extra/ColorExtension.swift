//
//  ColorExtension.swift
//  Libra
//
//  Created by Catalina on 19/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

extension Color {
    public static var maroon: Color {
        return Color(UIColor(red: 128/255, green: 0/255, blue: 0/255, alpha: 1.0))
    }
    
    public static var darkSlateGray: Color {
        return Color(UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1.0))
    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        assert(0x0...0xFFFFFF ~= rgb)
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

struct RandomColors {
    let theme: ColorScheme
    
    /**
    Colours taken from https://material.io/resources/color/#!/?view.left=0&view.right=0
     */
    private let bgColorsOnBlackText: [UIColor] = [
        UIColor(rgb: 0xff7961), // Red
        UIColor(rgb: 0xff6090), // Pink
        UIColor(rgb: 0xd05ce3), // Purple
        UIColor(rgb: 0x9a67ea), // Deep Purple
        UIColor(rgb: 0x757de8), // Indigo
        UIColor(rgb: 0x6ec6ff), // Blue
        UIColor(rgb: 0x67daff), // Light Blue
        UIColor(rgb: 0x62efff), // Cyan
        UIColor(rgb: 0x80e27e), // Green
        UIColor(rgb: 0xffff72), // Yellow
        UIColor(rgb: 0xffc947)  // Orange
        
    ]
    
    private let bgColorsOnWhiteText: [UIColor] = [
        UIColor(rgb: 0xba000d), // Red
        UIColor(rgb: 0xb0003a), // Pink
        UIColor(rgb: 0x6a0080), // Purple
        UIColor(rgb: 0x320b86), // Deep Purple
        UIColor(rgb: 0x002984), // Indigo
        UIColor(rgb: 0x0069c0), // Blue
        UIColor(rgb: 0x007ac1), // Light Blue
        UIColor(rgb: 0x008ba3), // Cyan
        UIColor(rgb: 0x087f23), // Green
        UIColor(rgb: 0xc8b900), // Yellow
        UIColor(rgb: 0xc66900)  // Orange
    ]
    
    private let specialBgColor: UIColor = UIColor()
    
    //
    func background(int input: Int) -> UIColor {
        switch(theme) {
        case .dark:
            let total = bgColorsOnWhiteText.count
            return bgColorsOnWhiteText[input % total]
        case .light:
            let total = bgColorsOnBlackText.count
            return bgColorsOnBlackText[input % total]
        @unknown default:
            print("ColorScheme Invalid")
            return specialBgColor
        }
    }
}




