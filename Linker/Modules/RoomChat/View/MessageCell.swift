//
//  MessageCell.swift
//  Linker
//
//  Created by Hossam on 09/10/2023.
//

import UIKit

class MessageCell: UITableViewCell {

  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var messageTextView: UITextView!
  @IBOutlet weak var messageStack: UIStackView!
  @IBOutlet weak var messageBubble: UIView!

  enum bubbleType {
    case incoming
    case outgoing
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  private func setupUI() {
    messageBubble.layer.cornerRadius = 6
  }

  func setMessageData(_ message: Message) {
    usernameLabel.text = message.senderName
    messageTextView.text = message.messageText
  }

  func setBubbleType(_ type: bubbleType) {
    if type == .outgoing {
      messageStack.alignment = .trailing
      messageBubble.backgroundColor = UIColor(named: Constants.OUTGOING_MSG_COLOR)
      messageTextView.textColor = .white

    } else if type == .incoming {
      messageStack.alignment = .leading
      messageBubble.backgroundColor = UIColor(named: Constants.INCOMING_MSG_COLOR)
      messageTextView.textColor = .black
    }
  }
}
