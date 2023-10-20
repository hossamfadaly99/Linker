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

  var presenter: RoomsPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

      presenter = RoomsPresenter(repository: Repository(networkManager: NetworkManager()))

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
      self.newRoomNameTF.text = Constants.EMPTY_STRING
    }
  }

  @IBAction private func didPressLogout(_ sender: UIButton) {
    Utilities.displayRedAlert(self, title: Constants.LOGOUT, text: Constants.LOGOUT_WARNING) {
      self.presenter.signOut {
        self.presentAuthenticationView()
      }
    }
  }

  private func presentAuthenticationView() {
    let authViewController = storyboard?.instantiateViewController(identifier: Constants.AUTHENTICAION_VIEW_CONTROLLER) as! AuthenticationViewController
    authViewController.modalPresentationStyle = .fullScreen
    present(authViewController, animated: true)
  }
}

