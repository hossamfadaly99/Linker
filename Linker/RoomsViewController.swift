//
//  RoomsViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit
import Firebase

class RoomsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if Auth.auth().currentUser == nil {
      presentAuthentication()
    }

  }

  @IBAction private func didPressLogout(_ sender: UIButton) {
    try! Auth.auth().signOut()
    presentAuthentication()
  }

  private func presentAuthentication() {
    let authViewController = storyboard?.instantiateViewController(identifier: "AuthViewController") as! ViewController
    authViewController.modalPresentationStyle = .fullScreen
    present(authViewController, animated: true)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
