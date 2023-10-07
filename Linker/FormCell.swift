//
//  FormCell.swift
//  Linker
//
//  Created by Hossam on 07/10/2023.
//

import UIKit
import TextFieldEffects

class FormCell: UICollectionViewCell {
  @IBOutlet weak var usernameTF: YoshikoTextField!
  @IBOutlet weak var passwordTF: YoshikoTextField!
  @IBOutlet weak var emailTF: YoshikoTextField!
  @IBOutlet weak var actionButton: UIButton!
  @IBOutlet weak var sliderButton: UIButton!

  private var isPasswordVisable = false

  @IBAction func changePasswordVisability(_ sender: UIButton) {
    print("rlgltrglntrgnj")
    isPasswordVisable.toggle()
    passwordTF.isSecureTextEntry = !isPasswordVisable
    print(passwordTF.isSecureTextEntry)
  }

  @IBAction func changeAuthentication(_ sender: UIButton) {
    
  }

}
