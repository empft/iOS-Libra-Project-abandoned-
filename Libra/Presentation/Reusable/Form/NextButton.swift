//
//  NextButton.swift
//  Libra
//
//  Created by Catalina on 17/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct NextButton: View {
    let action: () -> Void
    let text: String
    
    init(text: String = "Next", action: @escaping () -> Void) {
        self.action = action
        self.text = text
    }
  
    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                Text(text)
            }.padding(.trailing)
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(text: "Done", action: {})
    }
}
