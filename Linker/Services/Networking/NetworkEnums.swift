//
//  NetworkEnums.swift
//  Linker
//
//  Created by Hossam on 20/10/2023.
//

import Foundation

enum SignInError: Error {
  case networkConnectionError
  case invalidCredential

  var localizedDescription: String {
    switch self {
    case .networkConnectionError:
      return Constants.NO_Internet_CONNECTION
    case .invalidCredential:
      return Constants.INVALID_CREDINTIALS
    }
  }
}
