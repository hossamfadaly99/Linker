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
  var chatMessages: [Message] = []

  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var chatTF: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableView()
    observeMessages()
    Utilities.handleKeyboardDismissing(self)
  }

  private func setupTableView() {
    self.chatTableView.dataSource = self
  }

  private func observeMessages() {
    guard let roomId = room?.roomId else  { return }
    let databaseRef = Database.database().reference()
    databaseRef.child("rooms").child(roomId).child("messages").observe(.childAdded) { snapshot in
      if let dataArray = snapshot.value as? [String: Any] {
        guard let senderName = dataArray["senderName"] as? String,
              let messageText = dataArray["text"] as? String,
              let senderId = dataArray["senderId"] as? String else { return }
        let message = Message(messageKey: snapshot.key, senderName: senderName, messageText: messageText, senderId: senderId)

        self.chatMessages.append(message)
        self.chatTableView.reloadData()
        self.chatTableView.scrollToRow(at: IndexPath(row: self.chatMessages.count - 1, section: 0), at: .bottom, animated: false)
      }
    }
  }

  private func getUsernameWithId(uid: String, completion: @escaping (_ username: String?) -> () ) {

    let databaseReference = Database.database().reference()
    let user = databaseReference.child("users").child(uid)

    user.child("username").observeSingleEvent(of: .value) { snapshot in
      if let username = snapshot.value as? String {
        completion(username)
      } else {
        completion(nil)
      }
    }
  }

  private func sendMessage(text: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
    guard let userId = Auth.auth().currentUser?.uid else {
      return
    }

    let databaseReference = Database.database().reference()

    getUsernameWithId(uid: userId) { username in
      if let username = username,
         let roomId = self.room?.roomId,
         let senderId = Auth.auth().currentUser?.uid {

        let dataArray: [String: Any] = ["senderName": username, "text": text, "senderId": senderId]
        let room = databaseReference.child("rooms").child(roomId)
        room.child("messages").childByAutoId().setValue(dataArray) { error, databaseReference in
          if error == nil {
            completion(true)
          } else {
            completion(false)
          }
        }
      }
    }
  }

  @IBAction private func didPressSendMessage(_ sender: UIButton) {

    guard let chatText = self.chatTF.text, chatText.isEmpty == false else { return }

    sendMessage(text: chatText) { isSuccess in
      if isSuccess {
        self.chatTF.text = ""
      } else {
        Utilities.displayError(withText: "Message was not sent!", self)
      }
    }
  }

}


extension ChatRoomViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    chatMessages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
    let message = chatMessages[indexPath.row]
    cell.setMessageData(message)

    if let senderId = Auth.auth().currentUser?.uid, message.senderId == senderId {
      cell.setBubbleType(.outgoing)
    } else {
      cell.setBubbleType(.incoming)
    }
    return cell
  }

}
