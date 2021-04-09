//
//  ImageText.swift
//  Libra
//
//  Created by Big Sur on 31/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI

struct ImageText: View {
    
    var body: some View {
        VStack {
            Image("nfc")
                .resizable()
                .frame(width: 50, height: 50)
            
            Text("QR Pay")
        }
    }
}

struct ImageText_Previews: PreviewProvider {
    static var previews: some View {
        ImageText()
    }
}
