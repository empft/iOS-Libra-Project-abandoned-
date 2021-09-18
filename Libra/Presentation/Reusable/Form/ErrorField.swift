//
//  FormField.swift
//  Libra
//
//  Created by Catalina on 19/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct TextError {
    var text: String = ""
    var error: String = ""
}

struct ErrorField: View {
    var placeholder: String
    var onCommit: () -> Void
    @Binding var text: String
    @Binding var error: String
    
    init(_ placeholder: String, textError: Binding<TextError>, onCommit: @escaping () -> Void = {}) {
        self.placeholder = placeholder
        self._text = textError.text
        self._error = textError.error
        self.onCommit = onCommit
    }
    
    init(_ placeholder: String, text: Binding<String>, error: Binding<String>, onCommit: @escaping () -> Void = {}) {
        self.placeholder = placeholder
        self._text = text
        self._error = error
        self.onCommit = onCommit
    }

    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text, onCommit: {
                self.onCommit()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(color: self.hasError() ? .maroon: .clear, radius: 3, x: 0, y: 0)
    
            if hasError() {
                Text(error)
                    .font(.footnote)
                .foregroundColor(.red)
            }
            
        }
    }
    
    private func hasError() -> Bool {
        return error != ""
    }
}

struct ErrorField_Previews: PreviewProvider {
    static var previews: some View {
        ErrorField("heello", textError: .constant(TextError()))
    }
}
