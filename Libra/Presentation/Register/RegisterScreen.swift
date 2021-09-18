//
//  RegisterScreen.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showingAlert = false
    
    var body: some View {
        FlipView(
            AnyView(RegisterVerification()),
            AnyView(RegisterDisplayName()),
            AnyView(RegisterUsername()),
            AnyView(RegisterPassword()),
            AnyView(RegisterEmail()),
            AnyView(RegisterLoading())
        )
        
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: NavBackButton(text: "Login") {
                self.showingAlert = true
            })
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Quit Registration"), message: Text("Are you sure you want to leave?") , primaryButton: .destructive(Text("Yes"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                }), secondaryButton: .default(Text("No")))
            })
            .onTapGesture {
                self.hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.hideKeyboard()
    }
}

struct RegisterScreen: View {
    
    var body: some View {
        RegisterView().environmentObject(RegisterViewModel())
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
