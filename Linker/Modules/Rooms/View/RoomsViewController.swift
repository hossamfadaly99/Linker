//
//  RoomsViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit

class RoomsViewController: UIViewController {

  @IBOutlet weak var roomTableView: UITableView!
  @IBOutlet weak var newRoomNameTF: UITextField!

  private var presenter: RoomsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

      presenter = RoomsPresenter()

      setupTableView()
      presenter.observeRooms {
        self.roomTableView.reloadData()
      }
      Utilities.handleKeyboardDismissing(self)
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if !presenter.isThereCurentUser() {
      presentAuthenticationView()
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
    presenter.createNewRoom(withName: roomName) {
      self.newRoomNameTF.text = ""
    }
  }

  @IBAction private func didPressLogout(_ sender: UIButton) {
    Utilities.displayRedAlert(self, title: "Logout", text: "Are you sure you want to logout?") {
      self.presenter.signOut {
        self.presentAuthenticationView()
      }
    }
  }

  private func presentAuthenticationView() {
    let authViewController = storyboard?.instantiateViewController(identifier: "AuthViewController") as! AuthenticationViewController
    authViewController.modalPresentationStyle = .fullScreen
    present(authViewController, animated: true)
  }
}

extension RoomsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let chatRoomViewController = storyboard?.instantiateViewController(identifier: "chatRoomViewController") as! ChatRoomViewController
    chatRoomViewController.room = presenter.rooms[indexPath.row]
    self.navigationController?.pushViewController(chatRoomViewController, animated: true)
  }
}

extension RoomsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.rooms.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell")!
    var config = UIListContentConfiguration.cell()
    config.text = presenter.rooms[indexPath.row].roomName
    cell.contentConfiguration = config

    return cell
  }


}
