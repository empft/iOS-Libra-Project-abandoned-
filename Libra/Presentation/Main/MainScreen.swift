//
//  MainScreen.swift
//  Libra
//
//  Created by Catalina on 17/9/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        TabView {
            PaymentView()
                .tabItem {
                    Label("Payment", systemImage: "creditcard.fill")
                }
        }
        
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
