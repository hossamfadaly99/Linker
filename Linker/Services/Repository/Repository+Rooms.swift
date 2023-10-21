//
//  Repository+Rooms.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation

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
