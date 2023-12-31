//
//  ChatRoomViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit

class RoomChatViewController: UIViewController {

  var presenter: ChatPresenterProtocol!

  @IBOutlet weak var chatTableView: UITableView!
  @IBOutlet weak var chatTF: UITextField!
  weak var navigationCoordinator: NavigationCoordinatorProtocol?

  func configure(with presenter: ChatPresenterProtocol, navigationCoordinator: NavigationCoordinatorProtocol) {
    self.presenter = presenter
    self.navigationCoordinator = navigationCoordinator
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
    presenter.observeMessages {
      self.chatTableView.reloadData()
      self.chatTableView.scrollToRow(at: IndexPath(row: self.presenter.chatMessages.count - 1, section: 0), at: .bottom, animated: false)
    }
    Utilities.handleKeyboardDismissing(self)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationCoordinator?.movingBack()
  }

  private func setupTableView() {
    self.chatTableView.dataSource = self
  }

  @IBAction private func didPressSendMessage(_ sender: UIButton) {
    guard let chatText = self.chatTF.text, chatText.isEmpty == false else { return }

    presenter.sendMessage(text: chatText) { isSuccess in
      if isSuccess {
        self.chatTF.text = Constants.EMPTY_STRING
      } else {
        Utilities.displayError(withText: Constants.MSG_NOT_SENT, self)
      }
    }
  }
}
