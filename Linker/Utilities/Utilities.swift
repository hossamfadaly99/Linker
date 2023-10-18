//
//  Utilities.swift
//  Linker
//
//  Created by Hossam on 09/10/2023.
//

import UIKit

class Utilities {
  static func displayError(withText text: String, _ viewController: UIViewController) {
    let errorAlert = UIAlertController(title: Constants.ERROR, message: text, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: Constants.DISMISS, style: .default)
    errorAlert.addAction(dismissAction)
    viewController.present(errorAlert, animated: true)
  }

  static func handleKeyboardDismissing(_ viewController: UIViewController) {
    let swipeGesture = UISwipeGestureRecognizer(target: viewController.view, action: #selector(UIView.endEditing))
    swipeGesture.direction = [.down, .left, .right, .up]
    viewController.view.addGestureRecognizer(swipeGesture)
  }

  static func displayRedAlert(_ viewController: UIViewController, title: String, text: String, completion: @escaping VoidBlock) {
    let redAlert = UIAlertController(title: title, message: text, preferredStyle: .alert)
    let mainAction = UIAlertAction(title: title, style: .destructive) {_ in
      completion()
    }
    let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel)
    redAlert.addAction(mainAction)
    redAlert.addAction(cancelAction)
    viewController.present(redAlert, animated: true)
  }
}
