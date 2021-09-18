//
//  NavBackButton.swift
//  Libra
//
//  Created by Catalina on 25/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct NavBackButton: View {
    let text: String
    let action: () -> Void
    
    init(text: String, _ action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action:{
            self.action()
        }) {
            HStack {
                Image(systemName: Constants.CHEVRON)
                Text(text)
            }
        }
    }
}

struct NavBackButton_Previews: PreviewProvider {
    static var previews: some View {
        NavBackButton(text: "Back", {})
    }
}
