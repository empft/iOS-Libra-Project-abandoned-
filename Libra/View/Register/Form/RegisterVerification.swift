//
//  RegisterVerification.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI
import Combine

struct RegisterVerification: View, Flippable {
    @EnvironmentObject var pages: Flipper
    @EnvironmentObject var viewModel: RegisterViewModel
    
    @State var cancellable = Set<AnyCancellable>()
  
    let codeWidth = "0000000".sizeOfString(usingFont: .systemFont(ofSize: 25)).width
    
    var body: some View {
        let formattedCode = Binding(get: {
            self.viewModel.verificationCode.text
        }, set: {
            self.viewModel.verificationCode.text = String($0.prefix(6))
        })
        
        return VStack(alignment: .leading) {
            ErrorField("Verification Email", textError: $viewModel.verificationEmail)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
                .disableAutocorrection(true)
                .padding(.horizontal)
            
            Text("You need an email from chosen institutions to create an account")
                .font(.callout)
                .foregroundColor(.darkSlateGray)
                .multilineTextAlignment(.center)
                .padding([.leading, .bottom, .trailing])
            
            TimerButton(text: "Request Code", time: $viewModel.requestCodeCooldown, action: {
                self.viewModel.requestCode()
                    .store(in: &self.cancellable)
                })
            
            HStack {
                ErrorField("Code", text: formattedCode, error: $viewModel.verificationCode.error, onCommit: {
                    self.next()
                })
                    .frame(width: codeWidth)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
            
                Spacer()
            }
            
            NextButton(action: {
                self.next()
            }).disabled(isDisabled())
            
            Spacer()
            
        }.alert(isPresented: $viewModel.showingAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage))
            
        })
        .onDisappear {
            self.cancellable.removeAll()
        }
    }
    
    private func isDisabled() -> Bool {
        return viewModel.verificationEmail.text.isEmpty || viewModel.verificationCode.text.isEmpty
    
    }
    
    private func next() {
        guard !isDisabled() else { return }
        
        if viewModel.save(fields: [.verificationEmail, .verificationCode]) {
            self.pages.increment()
        }
    }

}

struct RegisterVerification_Previews: PreviewProvider {
    static var previews: some View {
        RegisterVerification().environmentObject(RegisterViewModel())
    }
}
