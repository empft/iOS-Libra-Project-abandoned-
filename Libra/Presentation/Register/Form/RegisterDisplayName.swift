//
//  RegisterDisplayName.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct RegisterDisplayName: View, Flippable {
    @EnvironmentObject var pages: Flipper
    @EnvironmentObject var viewModel: RegisterViewModel


    var body: some View {
        VStack(alignment: .leading) {
            ErrorField("Display Name", textError: $viewModel.displayName, onCommit: {
                print("test")
                self.next()
            })
                .disableAutocorrection(true)
                .padding(.horizontal)
            
            NextButton (action: {
                self.next()
                }).disabled(isDisabled())
            
            Spacer()
        }
    }
    
    private func isDisabled() -> Bool {
        return viewModel.displayName.text.isEmpty
    }
    
    private func next() {
        guard !isDisabled() else { return }
        
        if viewModel.save(fields: [.displayName]) {
            self.pages.increment()
        }
    }
    
}

struct RegisterDisplayName_Previews: PreviewProvider {
    static var previews: some View {
        RegisterDisplayName().environmentObject(RegisterViewModel())
        
    }
}
