//
//  RegisterEmail.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct RegisterEmail: View, Flippable {
    @EnvironmentObject var pages: Flipper
    @EnvironmentObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            ErrorField("Recovery Email", textError: $viewModel.email, onCommit: {
                self.next()
            })
            .disableAutocorrection(true)
            .padding(.horizontal)
            
            NextButton (text: "Done" ,action: {
                self.next()
                }).disabled(isDisabled())
            
            Spacer()
        }
    }
    
    private func isDisabled() -> Bool {
        return viewModel.email.text.isEmpty
    }
    
    private func next() {
        guard !isDisabled() else { return }
        
        if viewModel.save(fields: [.email]) {
            self.pages.increment()
        }
    }
}

struct RegisterEmail_Previews: PreviewProvider {
    static var previews: some View {
        RegisterEmail().environmentObject(RegisterViewModel())
    }
}
