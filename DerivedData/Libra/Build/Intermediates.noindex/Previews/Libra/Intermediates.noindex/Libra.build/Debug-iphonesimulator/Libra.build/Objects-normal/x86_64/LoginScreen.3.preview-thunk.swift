@_private(sourceFile: "LoginScreen.swift") import Libra
import SwiftUI
import SwiftUI

extension LoginScreen_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/catalina/Desktop/Libra/Libra/View/Login/LoginScreen.swift", line: 70)
        AnyView(__designTimeSelection(LoginScreen().accentColor(.red), "#4644.[2].[0].property.[0].[0]"))
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
        AnyView(__designTimeSelection(NavigationView {
            __designTimeSelection(VStack {
                __designTimeSelection(VStack(spacing: __designTimeInteger("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[0].value", fallback: 0)) {
                    __designTimeSelection(Group {
                        __designTimeSelection(TextField(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].arg[0].value.[0].value", fallback: "Username"), text: __designTimeSelection($username, "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].arg[1].value")).autocapitalization(.none), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0]")
                        
                        __designTimeSelection(SecureField(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1].arg[0].value.[0].value", fallback: "Password"), text: __designTimeSelection($password, "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1].arg[1].value"), onCommit: {
                            __designTimeSelection(self.signIn(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1].arg[2].value.[0]")
                            }), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].arg[0].value.[1]")
                    }.textFieldStyle(__designTimeSelection(RoundedBorderTextFieldStyle(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0].modifier[0].arg[0].value")), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0].arg[1].value.[0]")
                    
                }.padding(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[0]")
                
                __designTimeSelection(Group {
                    __designTimeSelection(Button(action: {
                        __designTimeSelection(self.signIn(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].arg[0].value.[0]")
                    }) {
                        __designTimeSelection(Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].arg[1].value.[0].arg[0].value.[0].value", fallback: "Sign In")), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].arg[1].value.[0]")
                    }.disabled(__designTimeSelection(isButtonEnabled(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0].modifier[0].arg[0].value")), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[0]")
                    
                    __designTimeSelection(NavigationLink(destination: /*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Destination@*/__designTimeSelection(Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1].arg[0].value.arg[0].value.[0].value", fallback: "Destination")), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1].arg[0].value")/*@END_MENU_TOKEN@*/) {
                        __designTimeSelection(Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1].arg[1].value.[0].arg[0].value.[0].value", fallback: "Forget Password")), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1].arg[1].value.[0]")
                    }, "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[1]")
                    
                    __designTimeSelection(Spacer(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[2]")
                
                    __designTimeSelection(NavigationLink(destination: __designTimeSelection(RegisterScreen(), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[3].arg[0].value")) {
                        __designTimeSelection(Text(__designTimeString("#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[3].arg[1].value.[0].arg[0].value.[0].value", fallback: "Register An Account")), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[3].arg[1].value.[0]")
                    }, "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1].arg[0].value.[3]")

                }.padding(.bottom), "#4644.[1].[3].property.[0].[0].arg[0].value.[0].arg[0].value.[1]")
            }, "#4644.[1].[3].property.[0].[0].arg[0].value.[0]")
        }, "#4644.[1].[3].property.[0].[0]"))
#sourceLocation()
    }
}

typealias LoginScreen = Libra.LoginScreen
typealias LoginScreen_Previews = Libra.LoginScreen_Previews