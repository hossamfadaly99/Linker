//
//  ViewController.swift
//  Linker
//
//  Created by Hossam on 06/10/2023.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {

  @IBOutlet weak var usernameTF: AkiraTextField!
  @IBOutlet weak var passwordTF: AkiraTextField!
  @IBOutlet weak var mailTF: AkiraTextField!
  @IBOutlet weak var collectionView: UICollectionView!

  private var isPasswordVisable = false

  override func viewDidLoad() {
    super.viewDidLoad()

    setupCollecionView()

//    passwordTF.borderColor = .red
//    passwordTF.placeholderColor = .red
  }

  private func setupCollecionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  @IBAction func changePasswordVisability(_ sender: UIButton) {
    isPasswordVisable.toggle()
    passwordTF.isSecureTextEntry = !isPasswordVisable
  }
}

extension ViewController: UICollectionViewDelegate {}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    2
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formCell", for: indexPath)

    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 350)
  }
}
