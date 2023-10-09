//
//  Utilities.swift
//  Linker
//
//  Created by Hossam on 09/10/2023.
//

import UIKit

class Utilities {
  static func displayError(errorText: String, _ viewController: UIViewController) {
    let errorAlert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
    errorAlert.addAction(dismissAction)
    viewController.present(errorAlert, animated: true)
  }

  static func handleKeyboardDismissing(_ viewController: UIViewController) {
    let swipeGesture = UISwipeGestureRecognizer(target: viewController.view, action: #selector(UIView.endEditing))
    swipeGesture.direction = [.down, .left, .right, .up]
    viewController.view.addGestureRecognizer(swipeGesture)
  }
}
