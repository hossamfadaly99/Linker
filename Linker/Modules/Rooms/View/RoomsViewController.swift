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
  weak var navigationCoordinator: NavigationCoordinatorProtocol?

  typealias roomBlock = (Room) -> RoomChatViewController
  var presenter: RoomsPresenterProtocol!
  var authenticationViewContoller: (() -> AuthenticationViewController)!
  var roomChatViewContoller: ((Room) -> RoomChatViewController)!

  func configure(with presenter: RoomsPresenterProtocol, navigationCoordinator: NavigationCoordinatorProtocol
  ) {
    self.presenter = presenter
    self.navigationCoordinator = navigationCoordinator
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

      setupTableView()
      presenter.observeRooms {
        self.roomTableView.reloadData()
      }
      Utilities.handleKeyboardDismissing(self)
    }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if !presenter.isThereCurentUser() {
      presentAuthenticationView()
    }
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationCoordinator?.movingBack()
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
    navigationCoordinator?.next(arguments: nil)
//    let authVC = authenticationViewContoller()
//    present(authVC, animated: true)
  }
}

