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
  var navigationCoordinator: NavigationCoordinatorProtocol! { get }

  typealias rootNavigationCoordinatorMaker = (UIViewController) -> NavigationCoordinatorProtocol
  func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinatorProtocol

  func makeAuthenticationViewController() -> AuthenticationViewController
  func makeRoomChatViewController(with room: Room) -> RoomChatViewController
}

class DependencyRegistery: DependencyRegisteryProtocol {
  var container: Container
  var navigationCoordinator: NavigationCoordinatorProtocol!

  init(container: Container) {

    Container.loggingFunction = nil
    self.container = container
    registerDependancies()
    registerPresenters()
    registerViewControllers()
  }

  func registerDependancies() {
    container.register(NavigationCoordinatorProtocol.self) { (r, rootViewController) in
      return RootNavigationCoordinator(registery: self, rootViewController: rootViewController)
    }.inObjectScope(.container)
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
      authenticationViewController.configure(with: presenter, navigationCoordinator: self.navigationCoordinator)
      return authenticationViewController
    }
    container.register(RoomChatViewController.self) { (r, room: Room) in
      let presenter = r.resolve(ChatPresenterProtocol.self, argument: room)!
      let roomChatViewController = UIStoryboard(name: Constants.MAIN, bundle: nil).instantiateViewController(identifier: Constants.ROOM_CHAT_VIEW_CONTROLLER) as! RoomChatViewController
      roomChatViewController.configure(with: presenter, navigationCoordinator: self.navigationCoordinator)
      return roomChatViewController
    }
  }

  func makeAuthenticationViewController() -> AuthenticationViewController {
    return container.resolve(AuthenticationViewController.self)!
  }

  func makeRoomChatViewController(with room: Room) -> RoomChatViewController {
    return container.resolve(RoomChatViewController.self, argument: room)!
  }

  func makeRootNavigationCoordinator(rootViewController: UIViewController) -> NavigationCoordinatorProtocol {
    navigationCoordinator = container.resolve(NavigationCoordinatorProtocol.self, argument: rootViewController)

    return navigationCoordinator
  }

}
