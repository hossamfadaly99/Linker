//
//  RoomPresenterProtocol.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation

protocol RoomsPresenterProtocol {
  var rooms: [Room] { get }
  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock)
  func observeRooms(completion: @escaping VoidBlock)
  func signOut (completion: @escaping VoidBlock)
  func isThereCurentUser() -> Bool
}
