//
//  AuthenticationPresenter.swift
//  Linker
//
//  Created by Hossam on 17/10/2023.
//

import Foundation

class AuthenticationPresenter: AuthenticationPresenterProtocol {
  let repository: RepositoryProtocol

  init(repository: RepositoryProtocol) {
    self.repository = repository
  }

  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void) {
    repository.SignUp(withUsername: username, email: email, password: password, compeletion: compeletion)
  }

  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void) {
    repository.signIn(withEmail: email, password: password, compeletion: compeletion)
  }
}
