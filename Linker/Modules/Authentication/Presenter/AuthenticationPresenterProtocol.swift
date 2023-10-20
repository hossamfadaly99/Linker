//
//  AuthenticationPresenterProtocol.swift
//  Linker
//
//  Created by Hossam on 20/10/2023.
//

import Foundation

protocol AuthenticationPresenterProtocol {
  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void)
  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void)
}
