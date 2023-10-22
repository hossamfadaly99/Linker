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


  init(with presenter: ChatPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: Constants.CHAT_ROOM_VIEW_CONTROLLER, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
