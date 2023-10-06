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

  private var isPasswordVisable = false

  @IBOutlet weak var userTF: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()

//    passwordTF.borderColor = .red
//    passwordTF.placeholderColor = .red
  }

  @IBAction func changePasswordVisability(_ sender: UIButton) {
    isPasswordVisable.toggle()
    passwordTF.isSecureTextEntry = !isPasswordVisable
  }

}

