@_private(sourceFile: "LoginScreen.swift") import Libra
import SwiftUI
import SwiftUI

extension LoginScreen_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/catalina/Desktop/Libra/Libra/View/Login/LoginScreen.swift", line: 70)
        AnyView(LoginScreen().accentColor(.red))
#sourceLocation()
    }
}

extension LoginScreen {
    @_dynamicReplacement(for: isValid()) private func __preview__isValid() -> Bool {
        #sourceLocation(file: "/Users/catalina/Desktop/Libra/Libra/View/Login/LoginScreen.swift", line: 64)
        return username.isEmpty || password.isEmpty
#sourceLocation()
    }
}

extension LoginScreen {
    @_dynamicReplacement(for: isButtonEnabled()) private func __preview__isButtonEnabled() -> Bool {
        #sourceLocation(file: "/Users/catalina/Desktop/Libra/Libra/View/Login/LoginScreen.swift", line: 60)
        return isValid() && !loading
#sourceLocation()
    }
}

extension LoginScreen {
    @_dynamicReplacement(for: signIn()) private func __preview__signIn() {
        #sourceLocation(file: "/Users/catalina/Desktop/Libra/Libra/View/Login/LoginScreen.swift", line: 53)
        guard isButtonEnabled() else { return }
#sourceLocation()
    }
}

extension LoginScreen {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/catalina/Desktop/Libra/Libra/View/Login/LoginScreen.swift", line: 17)
        AnyView(NavigationView {
            VStack {
                VStack(spacing: __designTimeInteger("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value", fallback: 0)) {
                    Group {
                        TextField(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].arg[0].value.[0].value", fallback: "Username"), text: $username).autocapitalization(.none)
                        
                        SecureField(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1].arg[0].value.[0].value", fallback: "Password"), text: $password, onCommit: {
                            self.signIn()
                            })
                    }.textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }.padding()
                
                Group {
                    Button(action: {
                        self.signIn()
                    }) {
                        Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].value", fallback: "Sign In"))
                    }.disabled(isButtonEnabled())
                    
                    NavigationLink(destination: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Destination@*/Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1].arg[0].value.arg[0].value.[0].value", fallback: "Destination"))/*@END_MENU_TOKEN@*/) {
                        Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].value", fallback: "Forget Password"))
                    }
                    
                    Spacer()
                
                    NavigationLink(destination: RegisterScreen()) {
                        Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[3].arg[1].value.[0].arg[0].value.[0].value", fallback: "Register An Account"))
                    }

                }.padding(.bottom)
            }
        })
#sourceLocation()
    }
}

typealias LoginScreen = Libra.LoginScreen
typealias LoginScreen_Previews = Libra.LoginScreen_Previews