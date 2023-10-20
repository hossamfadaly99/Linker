//
//  NetworkManager.swift
//  Linker
//
//  Created by Hossam on 20/10/2023.
//

import Foundation
import Firebase

class NetworkManager: Networkable {
  func SignUp(withUsername username: String, email: String, password: String, compeletion: @escaping (Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { result, error in
      if error == nil {
        guard let userId = result?.user.uid else { return }
        let reference = Database.database().reference()
        let user = reference.child(Constants.USERS).child(userId)
        let dataArray: [String:Any] = [Constants.USERNAME: username]
        user.setValue(dataArray) { error, _ in
          if error != nil {
            compeletion(error)
          }
          compeletion(nil)
        }
      } else {
        compeletion(error)
      }
    }
  }

  func signIn(withEmail email: String, password: String, compeletion: @escaping (SignInError?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if error == nil {
        compeletion(nil)
      } else {
        if let error = error as? NSError {
          let signInError = self.getSignInError(error: error)
          compeletion(signInError)
        }
      }
    }
  }

  private func getSignInError(error: NSError) -> SignInError {
    if error.code == Constants.NO_CONNECTION_FIREBASE_CODE {
      return .networkConnectionError
    } else {
      return .invalidCredential
    }
  }
}

extension Networkable {
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

  func observeRooms(completion: @escaping (Room) -> Void) {
    let databaseRef = Database.database().reference()
    databaseRef.child(Constants.ROOMS).observe(.childAdded) { snapshot,_  in
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
    if Auth.auth().currentUser == nil {
      return false
    }
    return true
  }
}
