//
//  RepositoryImpl.swift
//  Linker
//
//  Created by Hossam on 20/10/2023.
//

import Foundation

class Repository: RepositoryProtocol {
  let networkManager: Networkable

  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }
}
