//
//  RoomsViewController+TableView.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import UIKit

extension RoomsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let room = presenter.rooms[indexPath.row]
    let args = ["room": room]
//    let chatRoomViewController = roomChatViewContoller(presenter.rooms[indexPath.row])
//    self.navigationController?.pushViewController(chatRoomViewController, animated: true)
    navigationCoordinator!.next(arguments: args)
  }
}

extension RoomsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.rooms.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ROOM_CELL)!
    var config = UIListContentConfiguration.cell()
    config.text = presenter.rooms[indexPath.row].roomName
    cell.contentConfiguration = config

    return cell
  }
}
