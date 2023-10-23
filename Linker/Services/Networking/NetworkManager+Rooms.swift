//
//  NetworkManager+Rooms.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation
import Firebase

extension NetworkManager {
  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock) {
    let room = databaseReference.child(Constants.ROOMS).childByAutoId()

    let dataArry: [String: Any] = [Constants.ROOM_NAME: roomName]
    room.setValue(dataArry) { error, reference in
      if error == nil {
        completion()
      }
    }
  }

  func observeRooms(completion: @escaping (Room) -> Void) {
    databaseReference.child(Constants.ROOMS).observe(.childAdded) { snapshot,_  in
      if let dataArray = snapshot.value as? [String: Any] {
        if let roomName = dataArray[Constants.ROOM_NAME] as? String {
          let room = Room(roomName: roomName, roomId: snapshot.key)
          completion(room)
        }
      }
    }
  }

  func signOut (completion: @escaping VoidBlock) {
    try! Auth.auth().signOut()
    completion()
  }

  func isThereCurentUser() -> Bool {
    return Auth.auth().currentUser != nil
  }
}
