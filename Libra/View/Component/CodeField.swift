//
//  CodeField.swift
//  Libra
//
//  Created by Catalina on 17/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct CodeField: View {
    @Binding var code: String
    
    var body: some View {
        TextField("", text: $code)
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
    }
}

struct CodeField_Previews: PreviewProvider {
    static var previews: some View {
        CodeField(code: .constant("000000"))
    }
}
