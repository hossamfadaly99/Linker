//
//  Repository+Authentication.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation

extension Repository {
  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void) {
    networkManager.SignUp(withUsername: username, email: email, password: password, compeletion: compeletion)
  }

  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void) {
    networkManager.signIn(withEmail: email, password: password, compeletion: compeletion)
  }
}
