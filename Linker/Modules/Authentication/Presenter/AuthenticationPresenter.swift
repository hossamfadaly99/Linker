//
//  AuthenticationPresenter.swift
//  Linker
//
//  Created by Hossam on 17/10/2023.
//

import Foundation
import Firebase

class AuthenticationPresenter {

  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if error == nil {
        guard let userId = result?.user.uid else { return }
        let reference = Database.database().reference()
        let user = reference.child("users").child(userId)
        let dataArray: [String:Any] = ["username": username]
        user.setValue(dataArray) { error, _ in
          if error != nil {
            compeletion(error)
          }
          compeletion(nil)
        }
      } else {
        compeletion(error)
      }
    }
  }

  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if error == nil {
        compeletion(nil)
      } else {
        if let error = error as? NSError {
          let signInError = self.getSignInError(error: error)
          compeletion(signInError)
        }
      }
    }
  }

  func getSignInError(error: NSError) -> SignInError {
    if error.code == 17020 {
      return .networkConnectionError
    } else {
      return .invalidCredential
    }
  }

  enum SignInError: Error {
    case networkConnectionError
    case invalidCredential

    var localizedDescription: String {
      switch self {
      case .networkConnectionError:
        return "No Internet Connection!"
      case .invalidCredential:
        return "E-mail or password is invalid!"
      }
    }
  }
}