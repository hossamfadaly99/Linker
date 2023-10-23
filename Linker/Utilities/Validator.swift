//
//  Validation.swift
//  Linker
//
//  Created by Hossam on 17/10/2023.
//

import Foundation

class Validator {
    private static func isValidEmail(_ email: String?) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    private static func isValidUsername(_ username: String) -> Bool {
        let usernameRegex = "^[a-zA-Z0-9]{4,}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }

    private static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }

    static func validateSignUpFields(email: String, username: String, password: String) -> ValidationResult {
        if !isValidUsername(username) {
          return .invalidUsername
        } else if !isValidEmail(email) {
          return .invalidEmail
        } else if !isValidPassword(password) {
            return .invalidPassword
        }
        return .valid
    }

    static func validateSignInFields(email: String, password: String) -> ValidationResult {
        if !isValidEmail(email) {
            return .invalidEmail
        } else if !isValidPassword(password) {
            return .invalidPassword
        }
        return .valid
    }
}

enum ValidationResult {
    case valid
    case invalidEmail
    case invalidUsername
    case invalidPassword

  var error: String {
    switch self {
    case .invalidEmail:
      return "Please enter a valid email address!"
    case .valid:
      return "No Error, valid credintials"
    case .invalidUsername:
      return "Username must be at least 4 characters long and contain only letters and numbers!"
    case .invalidPassword:
      return "Password must be at least 6 characters long!"
    }
  }
}

