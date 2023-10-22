//
//  DependancyRegistery.swift
//  Linker
//
//  Created by Hossam on 22/10/2023.
//

import UIKit
import Swinject

protocol DependencyRegisteryProtocol {
  var container: Container { get }

  func makeAuthenticationViewController() -> AuthenticationViewController
  func makeRoomChatViewController(with room: Room) -> RoomChatViewController
}

class DependencyRegistery: DependencyRegisteryProtocol {

  var container: Container

  init(container: Container) {

    Container.loggingFunction = nil
    self.container = container
    registerDependancies()
    registerPresenters()
    registerViewControllers()
  }

  func registerDependancies() {
    container.register(Networkable.self) { _ in NetworkManager() }.inObjectScope(.container)
    container.register(RepositoryProtocol.self) { r in
      Repository(networkManager: r.resolve(Networkable.self)!)
    }.inObjectScope(.container)
  }

  func registerPresenters() {
    container.register(AuthenticationPresenterProtocol.self) { r in
      AuthenticationPresenter(repository: r.resolve(RepositoryProtocol.self)!)
    }.inObjectScope(.container)
    container.register(RoomsPresenterProtocol.self) { r in
      RoomsPresenter(repository: r.resolve(RepositoryProtocol.self)!)
    }.inObjectScope(.container)
    container.register(ChatPresenterProtocol.self) { (r, room: Room) in
      ChatPresenter(with: room, repository: r.resolve(RepositoryProtocol.self)!)
    }.inObjectScope(.transient)
  }

  func registerViewControllers() {
    container.register(AuthenticationViewController.self) { r in
      let presenter = r.resolve(AuthenticationPresenterProtocol.self)!
      let authenticationViewController = UIStoryboard(name: Constants.MAIN, bundle: nil).instantiateViewController(identifier: Constants.AUTHENTICAION_VIEW_CONTROLLER) as! AuthenticationViewController
      authenticationViewController.modalPresentationStyle = .fullScreen
      authenticationViewController.configure(with: presenter)
      return authenticationViewController
    }
    container.register(RoomChatViewController.self) { (r, room: Room) in
      let presenter = r.resolve(ChatPresenterProtocol.self, argument: room)!
      let roomChatViewController = UIStoryboard(name: Constants.MAIN, bundle: nil).instantiateViewController(identifier: Constants.ROOM_CHAT_VIEW_CONTROLLER) as! RoomChatViewController
      roomChatViewController.configure(with: presenter)
      return roomChatViewController
    }
  }

  func makeAuthenticationViewController() -> AuthenticationViewController {
    return container.resolve(AuthenticationViewController.self)!
  }

  func makeRoomChatViewController(with room: Room) -> RoomChatViewController {
    return container.resolve(RoomChatViewController.self, argument: room)!
  }

}
