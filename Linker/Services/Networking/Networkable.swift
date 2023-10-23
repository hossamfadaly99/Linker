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

  func observeMessages(roomId: String, compeletion: @escaping (Message) -> Void)
  func sendMessage(roomId: String, text: String, completion: @escaping (_ isSuccess: Bool) -> Void)
  func getCurrentUserId() -> String?
}
