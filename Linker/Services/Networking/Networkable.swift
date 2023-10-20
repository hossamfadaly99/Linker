//
//  Networkable.swift
//  Linker
//
//  Created by Hossam on 20/10/2023.
//

import Foundation

protocol Networkable {
  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void)
  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void)

  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock)
  func observeRooms(completion: @escaping (Room) -> Void)
  func signOut (completion: @escaping VoidBlock)
  func isThereCurentUser() -> Bool
}
