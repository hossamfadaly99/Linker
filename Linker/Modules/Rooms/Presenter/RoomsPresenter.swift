//
//  RoomsPresenter.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import Foundation
import Firebase

class RoomsPresenter {
  var rooms: [Room] = []

  func createNewRoom(withName roomName: String, completion: @escaping VoidBlock) {
    let databaseReference = Database.database().reference()
    let room = databaseReference.child(Constants.ROOMS).childByAutoId()

    let dataArry: [String: Any] = [Constants.ROOM_NAME: roomName]
    room.setValue(dataArry) { error, reference in
      if error == nil {
        completion()
      }
    }
  }

  func observeRooms(completion: @escaping VoidBlock) {
    let databaseRef = Database.database().reference()
    databaseRef.child(Constants.ROOMS).observe(.childAdded) { snapshot,_  in
      if let dataArray = snapshot.value as? [String: Any] {
        if let roomName = dataArray[Constants.ROOM_NAME] as? String {
          let room = Room(roomName: roomName, roomId: snapshot.key)
          self.rooms.append(room)
          completion()
        }
      }
    }
  }

  func signOut (completion: @escaping VoidBlock) {
    try! Auth.auth().signOut()
    completion()
  }

  func isThereCurentUser() -> Bool {
    if Auth.auth().currentUser == nil {
      return false
    }
    return true
  }
}
