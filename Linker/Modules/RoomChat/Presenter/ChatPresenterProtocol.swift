//
//  ChatPresenterProtocol.swift
//  Linker
//
//  Created by Hossam on 21/10/2023.
//

import Foundation

protocol ChatPresenterProtocol {
  func observeMessages(compeletion: @escaping () -> Void)
  func sendMessage(text: String, completion: @escaping (_ isSuccess: Bool) -> Void)
  func getCurrentUserId() -> String?
}
