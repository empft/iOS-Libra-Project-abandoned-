//
//  AppStart.swift
//  Libra
//
//  Created by Catalina on 17/9/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct AppStart: View {  
    
    @State var isLoggedIn: Bool
    
    init() {
        let appSession = AppSession()
        
        isLoggedIn = appSession.isLoggedIn()
    }
    
    @ViewBuilder
    var body: some View {
        if isLoggedIn {
            MainScreen()
        } else {
            LoginScreen()
        }
    }
}

struct AppStart_Previews: PreviewProvider {
    static var previews: some View {
        AppStart()
    }
}
