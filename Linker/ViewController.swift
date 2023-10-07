//
//  ViewController.swift
//  Linker
//
//  Created by Hossam on 06/10/2023.
//

import UIKit
import TextFieldEffects

class ViewController: UIViewController {

  
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
}

extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    2
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "formCell", for: indexPath) as! FormCell

    cell.sliderButton.configuration?.imagePadding = 8

    if indexPath.row == 0 { // sign in
      cell.usernameTF.isHidden = true
      cell.actionButton.setTitle("Sign In", for: .normal)
      cell.sliderButton.setTitle("Sign Up", for: .normal)
      cell.sliderButton.configuration?.imagePlacement = .trailing
      cell.sliderButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
      cell.sliderButton.addTarget(self, action: #selector(slideToSignUpCell(_:)), for: .touchUpInside)

    } else if indexPath.row == 1 {
      cell.usernameTF.isHidden = false
      cell.actionButton.setTitle("Sign Up", for: .normal)
      cell.sliderButton.setTitle("Sign In", for: .normal)
      cell.sliderButton.configuration?.imagePlacement = .leading
      cell.sliderButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
      cell.sliderButton.addTarget(self, action: #selector(slideToSignInCell(_:)), for: .touchUpInside)
    }
    return cell
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

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.size.width, height: 350)
  }
}
