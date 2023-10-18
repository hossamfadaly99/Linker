//
//  ChatPresenter.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import Foundation
import Firebase

class ChatPresenter {
  var room: Room?
  var chatMessages: [Message] = []
  private let databaseReference = Database.database().reference()

  init(with room: Room) {
    self.room = room
  }

  func observeMessages(compeletion: @escaping VoidBlock) {
    guard let roomId = room?.roomId else  { return }
    let messagesRef = databaseReference.child(Constants.ROOMS).child(roomId).child(Constants.MESSAGES)

    messagesRef.observe(.childAdded) { snapshot in
      guard let dataArray = snapshot.value as? [String: Any],
            let senderName = dataArray[Constants.SENDER_NAME] as? String,
            let messageText = dataArray[Constants.TEXT] as? String,
            let senderId = dataArray[Constants.SENDER_ID] as? String
      else { return }

      let message = Message(messageKey: snapshot.key, senderName: senderName, messageText: messageText, senderId: senderId)
      self.chatMessages.append(message)
      compeletion()
    }
  }

  func getUsernameWithId(uid: String, completion: @escaping (_ username: String?) -> Void) {
    let user = databaseReference.child("users").child(uid).child(Constants.USERNAME)
    user.observeSingleEvent(of: .value) { snapshot in
      completion(snapshot.value as? String)
    }
  }

  func getCurrentUserId() -> String? {
    return Auth.auth().currentUser?.uid
  }

  func sendMessage(text: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
    guard let userId = Auth.auth().currentUser?.uid,
          let roomId = room?.roomId else {
      completion(false)
      return
    }

    getUsernameWithId(uid: userId) { username in
      guard let username = username else {
        completion(false)
        return
      }

      let dataArray: [String: Any] = [Constants.SENDER_NAME: username, Constants.TEXT: text, Constants.SENDER_ID: userId]
      let roomRef = self.databaseReference.child(Constants.ROOMS).child(roomId)
      roomRef.child(Constants.MESSAGES).childByAutoId().setValue(dataArray) { error, databaseReference in
        completion(error == nil)
      }
    }
  }
}

