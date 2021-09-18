//
//  RegisterViewModel.swift
//  Libra
//
//  Created by Catalina on 23/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//
import Foundation
import Combine

private let COOLDOWN_TIME = 15

class RegisterViewModel: ObservableObject {
    
    private let loginRepository: LoginRepository = LoginRepository()
    
    @Published var verificationEmail: TextError = TextError()
    @Published var verificationCode: TextError = TextError()
    @Published var displayName: TextError = TextError()
    @Published var username: TextError = TextError()
    @Published var password: TextError = TextError()
    @Published var email: TextError = TextError()
    
    /// Used to indicate whether an async process is running, one process at a time
    @Published var isLoading: Bool = false
    
    /// Used to set an alert message
    private (set) var alertMessage = "" {
        didSet {
            showingAlert = true
        }
    }
    @Published var showingAlert: Bool = false
    
    /// Used to indicate whether user can send a request for email verification code to prevent spam (unit: seconds)
    @Published var requestCodeCooldown: Int = 0
    
    /// Register an account
    func register() -> AnyPublisher<Bool, Never> {
        loginRepository.register(form: getForm())
        .map { _ in
            return true
        }
        .catch { error -> Just<Bool> in
            return Just(false)
        }.eraseToAnyPublisher()
    }
    
    /// store the cancellable object
    /// Send a code request for an email
    func requestCode() -> AnyCancellable {
        requestCodeCooldown = COOLDOWN_TIME
        return loginRepository.requestCode(email: verificationEmail.text)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { errors in
                if !errors.isEmpty {
                    self.requestCodeCooldown = 0
                    self.alertMessage = errors.first!.localizedDescription
                }
            })
    }
    
    /// Check Fields that require async operation
    func asyncSave(field: AsyncField) -> AnyPublisher<Bool,Never> {
        
        self.isLoading = true

        switch field {
        case .username:
            return saveUsername().map { success in
                if !success {
                    Haptics.vibrate()
                }
                return success
                }.handleEvents(receiveCompletion: { _ in
                    self.isLoading = false
                }, receiveCancel: {
                    self.isLoading = false
            }).eraseToAnyPublisher()
        case .password:
            return savePassword().map { success in
                if !success {
                    Haptics.vibrate()
                }
                return success
            }.handleEvents(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveCancel: {
                self.isLoading = false
            }).eraseToAnyPublisher()
        }
    }
    
    /// Check fields
    func save(fields: Set<Field>) -> Bool {
        guard !fields.isEmpty else { return false }
        
        var success: Bool = true
        for field in fields {
            switch field {
            case .verificationEmail:
                success = saveVerificationEmail() && success
            case .verificationCode:
                success = saveVerificationCode() && success
            case .displayName:
                success = saveDisplayName() && success
            case .email:
                success = saveEmail() && success
            }
        }
        if !success {
            Haptics.vibrate()
        }
        return success
    }
    
    private func saveVerificationEmail() -> Bool {
        verificationEmail.error = ""
        if !verificationEmail.text.isEmail {
            verificationEmail.error = "Invalid Email Format"
            return false
        }
        return true
    }
    
    private func saveVerificationCode() -> Bool {
        verificationCode.error = ""
        if !verificationCode.text.isOTP {
            verificationCode.error = "Invalid Format"
            return false
        }
        return true
    }
    
    private func saveDisplayName() -> Bool {
        displayName.error = ""
        if displayName.text == username.text {
            displayName.error = "Display name must be different from username"
            return false
        }
        return true
    }
    
    private func saveUsername() -> AnyPublisher<Bool, Never> {
        username.error = ""
        
        if username.text == displayName.text {
            self.username.error = "Username must be different from display name"
            return Just(false)
                .eraseToAnyPublisher()
        }
        
        return loginRepository.usernameExists(username: username.text)
        .receive(on: DispatchQueue.main)
        .map { success in
            if !success {
                self.username.error = "Username is taken"
            }
            return success
        }.catch { error -> Just<Bool> in
            self.alertMessage = error.localizedDescription
            return Just(false)
        }.eraseToAnyPublisher()
    }
    
    private func savePassword() -> AnyPublisher<Bool, Never> {
        password.error = ""
        
        return Just(Constants.ARBITRARY)
        .receive(on: DispatchQueue.global(qos: .userInitiated))
        .map { _ -> Bool in
            return self.checkPasswordStrength()
        }
        .receive(on: DispatchQueue.main)
        .map { success in
            if !success {
                self.password.error = "Choose a stronger password"
            }
            return success
        }.eraseToAnyPublisher()
    }
    
    private func saveEmail() -> Bool {
        email.error = ""
        
        let patterns = ["\\.edu$","\\.edu\\.[a-z]{2}$","\\.ac\\.[a-z]{2}$"]
        var isInstitutionalEmail: Bool {
            for pattern in patterns {
                if email.text.matches(pattern: pattern) {
                    return true
                }
            }
            return false
        }
        
        if !email.text.isEmail {
            email.error = "Invalid Email Format"
            return false
        } else if isInstitutionalEmail {
            email.error = "Use your personal email"
            return false
        }
        return true
    }
    
    private func checkPasswordStrength() -> Bool {
        let path = Bundle.main.path(forResource: "one-million-password", ofType: "txt")!
        let reader = LineReader(path: path)!
        
        for line in reader {
            if password.text == line {
                return false
            }
        }
        return true
    }
    
    private func getForm() -> RegistrationForm {
        return RegistrationForm(
            verificationEmail: verificationEmail.text,
            verificationCode: verificationCode.text,
            displayName: displayName.text,
            username: username.text,
            password: password.text,
            email: email.text)
    }
    
    enum Field {
        case verificationEmail
        case verificationCode
        case displayName
        case email
    }
    
    enum AsyncField {
        case username
        case password
    }
}
