//
//  PaymentButton.swift
//  Libra
//
//  Created by Big Sur on 11/4/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI

struct PaymentButton: View {
    var body: some View {
        VStack {
            Image("nfc")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.primary)
                .aspectRatio(1, contentMode: .fit)
                
            Text("NFC Pay")
                .foregroundColor(.primary)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primary, lineWidth: 2)
                
        )
    }
}

struct PaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        PaymentButton()
            .frame(width: 100, height: 100, alignment: .center)
    
            
            
    }
}
