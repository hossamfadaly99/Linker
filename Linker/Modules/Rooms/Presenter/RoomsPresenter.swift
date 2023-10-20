//
//  RoomsPresenter.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import Foundation
import Firebase

protocol RoomsPresenterProtocol {
  var rooms: [Room] { get }
  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock)
  func observeRooms(completion: @escaping VoidBlock)
  func signOut (completion: @escaping VoidBlock)
  func isThereCurentUser() -> Bool
}

class RoomsPresenter: RoomsPresenterProtocol {
  var rooms: [Room] = []

  let repository: RepositoryProtocol

  init(repository: RepositoryProtocol) {
    self.repository = repository
  }

  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock) {
    repository.createNewRoom(withName: roomName, completion: completion)
  }

  func observeRooms(completion: @escaping VoidBlock) {
    repository.observeRooms { [weak self] room in
      guard let self = self else { return }
      self.rooms.append(room)
      completion()
    }
  }

  func signOut (completion: @escaping VoidBlock) {
    repository.signOut {
      completion()
    }
  }

  func isThereCurentUser() -> Bool {
    return Auth.auth().currentUser != nil
  }
}
