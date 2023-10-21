//
//  ViewController.swift
//  Linker
//
//  Created by Hossam on 06/10/2023.
//

import UIKit
import TextFieldEffects

class AuthenticationViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  var presenter: AuthenticationPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollecionView()
    Utilities.handleKeyboardDismissing(self)
    presenter = AuthenticationPresenter(repository: Repository(networkManager: NetworkManager()))
  }

  private func setupCollecionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}
