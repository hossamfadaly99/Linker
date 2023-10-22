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

  init(with presenter: AuthenticationPresenterProtocol) {
    self.presenter = presenter
    super.init(nibName: Constants.AUTHENTICAION_VIEW_CONTROLLER, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
