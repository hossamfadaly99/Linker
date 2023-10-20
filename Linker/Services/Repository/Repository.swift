//
//  RepositoryImpl.swift
//  Linker
//
//  Created by Hossam on 20/10/2023.
//

import Foundation

class Repository: RepositoryProtocol {
  let networkManager: Networkable

  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void) {
    networkManager.SignUp(withUsername: username, email: email, password: password, compeletion: compeletion)
  }

  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void) {
    networkManager.signIn(withEmail: email, password: password, compeletion: compeletion)
  }
}

extension Repository {
  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock) {
    networkManager.createNewRoom(withName: roomName, completion: completion)
  }

  func observeRooms(completion: @escaping (Room) -> Void) {
    networkManager.observeRooms(completion: completion)
  }

  func signOut(completion: @escaping VoidBlock) {
    networkManager.signOut(completion: completion)
  }

  func isThereCurentUser() -> Bool {
    networkManager.isThereCurentUser()
  }
}
