//
//  RoomsViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit
import Firebase

class RoomsViewController: UIViewController {

  @IBOutlet weak var roomTableView: UITableView!
  @IBOutlet weak var newRoomNameTF: UITextField!

  var rooms: [Room] = []

    override func viewDidLoad() {
        super.viewDidLoad()

      setupTableView()
      observeRooms()
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if Auth.auth().currentUser == nil {
      presentAuthentication()
    }
  }

  private func setupTableView() {
    roomTableView.dataSource = self
    roomTableView.delegate = self
  }

  @IBAction private func didPressCreateNewRoom(_ sender: UIButton) {
    guard let roomName = newRoomNameTF.text, roomName.isEmpty == false else {
      return
    }
    let databaseReference = Database.database().reference()
    let room = databaseReference.child("rooms").childByAutoId()

    let dataArry: [String: Any] = ["roomName": roomName]
    room.setValue(dataArry) { error, reference in
      if error == nil {
        self.newRoomNameTF.text = ""
      }
    }
  }

  private func observeRooms() {
    let databaseRef = Database.database().reference()
    let rooms = databaseRef.child("rooms").observe(.childAdded) { snapshot in
      if let dataArray = snapshot.value as? [String: Any] {
        if let roomName = dataArray["roomName"] as? String {
          let room = Room(roomName: roomName)
          self.rooms.append(room)
          self.roomTableView.reloadData()
        }
      }

    }
  }

  @IBAction private func didPressLogout(_ sender: UIButton) {
    try! Auth.auth().signOut()
    presentAuthentication()
  }

  private func presentAuthentication() {
    let authViewController = storyboard?.instantiateViewController(identifier: "AuthViewController") as! ViewController
    authViewController.modalPresentationStyle = .fullScreen
    present(authViewController, animated: true)
  }
}

extension RoomsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let chatRoomViewController = storyboard?.instantiateViewController(identifier: "chatRoomViewController") as! ChatRoomViewController

    self.navigationController?.pushViewController(chatRoomViewController, animated: true)

  }
}

extension RoomsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    rooms.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell")!
    var config = UIListContentConfiguration.cell()
    config.text = rooms[indexPath.row].roomName
    cell.contentConfiguration = config


    return cell
  }


}
