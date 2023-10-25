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
  weak var navigationCoordinator: NavigationCoordinatorProtocol?

  func configure(with presenter: AuthenticationPresenterProtocol, navigationCoordinator: NavigationCoordinatorProtocol) {
    self.presenter = presenter
    self.navigationCoordinator = navigationCoordinator
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollecionView()
    Utilities.handleKeyboardDismissing(self)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationCoordinator?.movingBack()
  }

  private func setupCollecionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}
