//
//  ChatRoomViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit
import Firebase

class ChatRoomViewController: UIViewController {

  var room: Room?

  @IBOutlet weak var chatTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

  @IBAction private func didPressSendMessage(_ sender: UIButton) {
    guard let chatText = self.chatTF.text, chatText.isEmpty == false, let userId = Auth.auth().currentUser?.uid else {
      return
    }

    let databaseReference = Database.database().reference()
    let user = databaseReference.child("users").child(userId)

    user.child("username").observeSingleEvent(of: .value) { snapshot in
      if let username = snapshot.value {
        if let roomId = self.room?.roomId {
          let dataArray: [String: Any] = ["senderName": username, "text": chatText]
          let room = databaseReference.child("rooms").child(roomId)
          room.child("messages").childByAutoId().setValue(dataArray) { error, databaseReference in
            if error == nil {
              self.chatTF.text = ""
            }
          }
        }
      }
    }


  }

}
