//
//  Authentication+CollectionView.swift
//  Linker
//
//  Created by Hossam on 18/10/2023.
//

import UIKit

extension AuthenticationViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    2
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.FORM_CELL, for: indexPath) as! FormCell
    cell.sliderButton.configuration?.imagePadding = 8

    if indexPath.row == 0 { // sign in
      configureCellUI(cell, authType: .signIn)
    } else if indexPath.row == 1 {
      configureCellUI(cell, authType: .signUp)
    }
    return cell
  }

  enum AuthenticationType {
    case signIn
    case signUp
  }

  private func configureCellUI(_ cell: FormCell, authType: AuthenticationType) {
    if authType == .signIn {
      cell.usernameTF.isHidden = true
      cell.actionButton.setTitle(Constants.SIGN_IN, for: .normal)
      cell.sliderButton.setTitle(Constants.SIGN_UP, for: .normal)
      cell.sliderButton.configuration?.imagePlacement = .trailing
      cell.sliderButton.setImage(UIImage(systemName: Constants.CHEVRON_RIGHT), for: .normal)

      cell.sliderButton.addTarget(self, action: #selector(slideToSignUpCell(_:)), for: .touchUpInside)
      cell.actionButton.addTarget(self, action: #selector(didPressSignIn(_:)), for: .touchUpInside)
    } else {
      cell.usernameTF.isHidden = false
      cell.actionButton.setTitle(Constants.SIGN_UP, for: .normal)
      cell.sliderButton.setTitle(Constants.SIGN_IN, for: .normal)
      cell.sliderButton.configuration?.imagePlacement = .leading
      cell.sliderButton.setImage(UIImage(systemName: Constants.CHEVRON_LEFT), for: .normal)

      cell.sliderButton.addTarget(self, action: #selector(slideToSignInCell(_:)), for: .touchUpInside)
      cell.actionButton.addTarget(self, action: #selector(didPressSignUp(_:)), for: .touchUpInside)
    }

  }

  @objc func didPressSignUp(_ sender: UIButton) {
    let indexPath = IndexPath(row: 1, section: 0)
    let cell = self.collectionView.cellForItem(at: indexPath) as! FormCell

    guard let emailAddress = cell.emailTF.text,
          let username = cell.usernameTF.text,
          let password = cell.passwordTF.text
    else { return }

    let validationResult =  Validator.validateSignUpFields(email: emailAddress, username: username, password: password)
    switch validationResult {
    case .valid:
      presenter.SignUp(withUsername: username, email: emailAddress, password: password) {  error in
        if let error = error {
          Utilities.displayError(withText: error.localizedDescription, self)
          return
        }
        self.dismiss(animated: true)
      }
    default:
      Utilities.displayError(withText: validationResult.error, self)
    }
  }

  @objc func didPressSignIn(_ sender: UIButton) {
    let indexPath = IndexPath(row: 0, section: 0)
    let cell = self.collectionView.cellForItem(at: indexPath) as! FormCell

    guard let emailAddress = cell.emailTF.text,
          let password = cell.passwordTF.text
    else { return }

    let validationResult =  Validator.validateSignInFields(email: emailAddress, password: password)
    if validationResult == .valid {
      presenter.signIn(withEmail: emailAddress, password: password) { error in
        if error == nil {
          self.dismiss(animated: true)
        } else {
          Utilities.displayError(withText: error!.localizedDescription, self)
        }
      }
    } else {
      Utilities.displayError(withText: validationResult.error, self)
    }
  }

  @objc func slideToSignUpCell(_ sender: UIButton) {
    let indexPath = IndexPath(row: 1, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }

  @objc func slideToSignInCell(_ sender: UIButton) {
    let indexPath = IndexPath(row: 0, section: 0)
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

extension AuthenticationViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 350)
  }
}
