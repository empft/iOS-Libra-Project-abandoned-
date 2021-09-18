//
//  RegisterPassword.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI
import Combine

struct RegisterPassword: View, Flippable {
    @EnvironmentObject var pages: Flipper
    @EnvironmentObject var viewModel: RegisterViewModel
    
    @State var cancellable = Set<AnyCancellable>()

    var body: some View {
        VStack(alignment: .leading) {
            ErrorField("Password", textError: $viewModel.password, onCommit: {
                self.next()
            })
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.horizontal)
            
            LoadableButton (action: {
                self.next()
            }, text: "Next", isLoading: $viewModel.isLoading).disabled(isDisabled())

            Spacer()
        }.onDisappear {
            self.cancellable.removeAll()
        }
    }
    
    private func isDisabled() -> Bool {
        return viewModel.password.text.count < 8 || viewModel.isLoading
    }
    
    private func next() {
        guard !isDisabled() else { return }
        
        viewModel.asyncSave(field: .password)
        .sink(receiveValue: { success in
            if success {
                self.pages.increment()
            }
        })
        .store(in: &cancellable)
    }
}

struct RegisterPassword_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPassword().environmentObject(RegisterViewModel())
    }
}
