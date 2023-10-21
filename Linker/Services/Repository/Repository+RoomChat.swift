//
//  Repository+RoomChat.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation

extension Repository {
  func observeMessages(roomId: String, compeletion: @escaping (Message) -> Void) {
    networkManager.observeMessages(roomId: roomId, compeletion: compeletion)
  }

  func sendMessage(roomId: String, text: String, completion: @escaping (Bool) -> Void) {
    networkManager.sendMessage(roomId: roomId, text: text, completion: completion)
  }

  func getCurrentUserId() -> String? {
    networkManager.getCurrentUserId()
  }
}
