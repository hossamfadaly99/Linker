//
//  ChatPresenter.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import Foundation

class ChatPresenter: ChatPresenterProtocol {

  var room: Room?
  var chatMessages: [Message] = []
  let repository: RepositoryProtocol

  init(with room: Room, repository: RepositoryProtocol) {
    self.room = room
    self.repository = repository
  }

  func observeMessages(compeletion: @escaping () -> Void) {
    guard let roomId = room?.roomId else { return }
    repository.observeMessages(roomId: roomId) { [weak self] message in
      guard let self = self else { return }
      self.chatMessages.append(message)
      compeletion()
    }
  }

  func sendMessage(text: String, completion: @escaping (Bool) -> Void) {
    guard let roomId = room?.roomId else { return }
    repository.sendMessage(roomId: roomId, text: text, completion: completion)
  }

  func getCurrentUserId() -> String? {
    repository.getCurrentUserId()
  }
}

