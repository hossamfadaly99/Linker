//
//  DependancyRegistery.swift
//  Linker
//
//  Created by Hossam on 22/10/2023.
//

import Foundation
import Swinject

protocol DependencyRegisteryProtocol {
  var container: Container { get }
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
    container.register(Networkable.self) { _ in NetworkManager() }.inObjectScope(.weak)
    container.register(RepositoryProtocol.self) { r in
      Repository(networkManager: r.resolve(Networkable.self)!)
    }.inObjectScope(.weak)
  }

  func registerPresenters() {
    container.register(AuthenticationPresenterProtocol.self) { r in
      AuthenticationPresenter(repository: r.resolve(RepositoryProtocol.self)!)
    }.inObjectScope(.weak)
    container.register(RoomsPresenterProtocol.self) { r in
      RoomsPresenter(repository: r.resolve(Repository.self)!)
    }.inObjectScope(.weak)
    container.register(ChatPresenterProtocol.self) { (r, room: Room) in
      ChatPresenter(with: room, repository: r.resolve(RepositoryProtocol.self)!)
    }.inObjectScope(.weak)
  }

  func registerViewControllers() {
    container.register(AuthenticationViewController.self) { r in
      let presenter = r.resolve(AuthenticationPresenter.self)!
      return AuthenticationViewController(with: presenter)
    }
    container.register(RoomChatViewController.self) { r in
      let presenter = r.resolve(ChatPresenter.self)!
      return RoomChatViewController(with: presenter)
    }
  }

}
