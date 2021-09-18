//
//  LoginScreen.swift
//  Libra
//
//  Created by Catalina on 11/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    Group {
                        TextField("Username", text: $username)
                            .autocapitalization(.none)
                        .disableAutocorrection(true)
                            .textContentType(.username)
                        
                        SecureField("Password", text: $password, onCommit: {
                            self.signIn()
                            }).disableAutocorrection(true)
                            .textContentType(.password)
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }.padding()
                
                Group {
                    Button(action: {
                        self.signIn()
                    }) {
                        Text("Sign In")
                    }.disabled(isButtonEnabled())
                    
                    NavigationLink(destination: ForgetScreen()) {
                        Text("Forget Username/Password")
                    }
                    
                    Spacer()
                
                    NavigationLink(destination: RegisterScreen()) {
                        Text("Register An Account")
                    }
                }.padding(.bottom)
            }.onTapGesture {
                self.hideKeyboard()
            }
        }
    }
    
    private func signIn() {
        guard isButtonEnabled() else { return }
        
        
        
    }
    
    private func isButtonEnabled() -> Bool {
        return isValid() && !loading
    }
    
    private func isValid() -> Bool {
        return username.isEmpty || password.isEmpty
    }
    
    private func hideKeyboard() {
        UIApplication.shared.hideKeyboard()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().accentColor(.red)
    }
}
