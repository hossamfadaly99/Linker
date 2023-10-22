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

  func configure(with presenter: AuthenticationPresenterProtocol) {
    self.presenter = presenter
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollecionView()
    Utilities.handleKeyboardDismissing(self)
  }

  private func setupCollecionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}
