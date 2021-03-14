//
//  LoadableButton.swift
//  Libra
//
//  Created by Catalina on 20/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct LoadableButton: View {
    let action: () -> Void
    let text: String
    @Binding var isLoading: Bool
    
    var body: some View {
        HStack() {
            Spacer()
            
            if isLoading {
                Loading()
            }
            
            Button(action: action) {
                Text(text)
            }.padding(.trailing)
        }
    }
}

struct LoadableButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadableButton(action: {}, text: "Next", isLoading: .constant(true))
    }
}
