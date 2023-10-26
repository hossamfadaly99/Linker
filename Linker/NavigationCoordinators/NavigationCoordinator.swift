//
//  NavigationCoordinator.swift
//  Linker
//
//  Created by Hossam on 25/10/2023.
//

import UIKit

protocol NavigationCoordinatorProtocol: AnyObject {
  func next(arguments: Dictionary<String,Any>?)
  func movingBack()
}

enum NavigationState {
  case atAuthentication,
  atRooms,
  atRoomChat
}

class RootNavigationCoordinator: NavigationCoordinatorProtocol {
  var registery: DependencyRegisteryProtocol
  var rootViewController: UIViewController
  var navState: NavigationState = .atRooms

  init(registery: DependencyRegisteryProtocol, rootViewController: UIViewController) {
    self.registery = registery
    self.rootViewController = rootViewController
  }

  func next(arguments: Dictionary<String, Any>?) {
    switch navState {
    case .atAuthentication:
      showRooms()
    case .atRooms:
      if let arguments = arguments {
        showRoomChat(arguments: arguments)
      } else {
        showAuthentication()
      }
    case .atRoomChat:
      break
    }
  }

  func movingBack() {
    switch navState {
    case .atAuthentication:
      navState = .atRooms
    case .atRooms:
      break
    case .atRoomChat:
      navState = .atRooms
    }
  }

  func showRooms() {
    rootViewController.dismiss(animated: true)
    rootViewController.navigationController?.popToRootViewController(animated: true)
    navState = .atRooms
  }

  func showRoomChat(arguments: Dictionary<String, Any>?) {
    guard let room = arguments?["room"] as? Room else { notifyNilArguments(); return }

    let roomChatviewController = registery.makeRoomChatViewController(with: room)
    rootViewController.navigationController?.pushViewController(roomChatviewController, animated: true)
    navState = .atRoomChat
  }

  func showAuthentication() {
    let authenticationViewController = registery.makeAuthenticationViewController()
    rootViewController.present(authenticationViewController, animated: true)
  }

  func notifyNilArguments() {
    print("nil arguments!")
  }
}
