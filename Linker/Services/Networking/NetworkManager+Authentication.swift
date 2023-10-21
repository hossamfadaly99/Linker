//
//  NetworkManager+Authentication.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation
import Firebase

extension NetworkManager {
  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
      if error == nil {
        guard let userId = result?.user.uid,
              let self = self else { return }
        let user = self.databaseReference.child(Constants.USERS).child(userId)
        let dataArray: [String:Any] = [Constants.USERNAME: username]
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

  private func getSignInError(error: NSError) -> SignInError {
    if error.code == Constants.NO_CONNECTION_FIREBASE_CODE {
      return .networkConnectionError
    } else {
      return .invalidCredential
    }
  }
}
