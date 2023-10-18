//
//  RoomChatViewController+TableView.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import UIKit

extension RoomChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.chatMessages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MESSAGE_CELL) as! MessageCell
    let message = presenter.chatMessages[indexPath.row]
    cell.setMessageData(message)

    if let senderId = presenter.getCurrentUserId(), message.senderId == senderId {
      cell.setBubbleType(.outgoing)
    } else {
      cell.setBubbleType(.incoming)
    }
    return cell
  }
}
