//
//  RegistrationForm.swift
//  Libra
//
//  Created by Catalina on 12/07/2020.
//  Copyright © 2020 Catalina. All rights reserved.
//
import Foundation

class RegistrationForm {
    var verificationEmail: String = ""
    var verificationCode: String = ""
    var displayName: String = ""
    var username: String = ""
    var password: String = ""
    var email: String = ""
    
    init(verificationEmail: String = "", verificationCode: String = "", displayName: String = "", username: String = "", password: String = "", email: String = "") {
        self.verificationEmail = verificationEmail
        self.verificationCode = verificationCode
        self.displayName = displayName
        self.username = username
        self.password = password
        self.email = email
    }
}
