//
//  ChatRoomViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit

class ChatRoomViewController: UIViewController {

  @IBOutlet weak var sendMessageButton: UIButton!
  @IBOutlet weak var chatTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

  @IBAction private func didPressSendMessage(_ sender: UIButton) {
    guard let chatText = self.chatTF.text, chatText.isEmpty == false else {
      return
    }

  }

}
