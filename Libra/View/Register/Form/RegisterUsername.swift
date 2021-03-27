//
//  RegisterUsername.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI
import Combine

struct RegisterUsername: View, Flippable {
    @EnvironmentObject var pages: Flipper
    @EnvironmentObject var viewModel: RegisterViewModel
    
    @State var cancellable = Set<AnyCancellable>()

    var body: some View {
        VStack(alignment: .leading) {
            ErrorField("Username", textError: $viewModel.username, onCommit: {
                self.next()
            })
                .disableAutocorrection(true)
                .padding(.horizontal)
            
            LoadableButton (action: {
                self.next()
            }, text: "Next", isLoading: $viewModel.isLoading).disabled(isDisabled())
            
            Spacer()
        }.alert(isPresented: $viewModel.showingAlert, content: {
            Alert(title: Text("Error"), message: Text(viewModel.alertMessage))
            
        }).onDisappear {
            self.cancellable.removeAll()
        }
    }
    
    private func isDisabled() -> Bool {
        return viewModel.username.text.isEmpty || viewModel.isLoading
    }
    
    private func next() {
        guard !isDisabled() else { return }
        
        self.pages.increment()
        
        //TODO: Uncomment during release
        /*
        viewModel.asyncSave(field: .username)
        .sink(receiveValue: { success in
            if success {
                self.pages.increment()
            }
        })
        .store(in: &cancellable)
        */
    }
}

struct RegisterUsername_Previews: PreviewProvider {
    static var previews: some View {
        RegisterUsername().environmentObject(RegisterViewModel())
    }
}
