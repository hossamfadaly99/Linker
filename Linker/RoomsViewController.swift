//
//  RoomsViewController.swift
//  Linker
//
//  Created by Hossam on 08/10/2023.
//

import UIKit
import Firebase

class RoomsViewController: UIViewController {

  @IBOutlet weak var roomTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

      setupTableView()
    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if Auth.auth().currentUser == nil {
      presentAuthentication()
    }
  }

  private func setupTableView() {
    roomTableView.dataSource = self
    roomTableView.delegate = self
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
}

extension RoomsViewController: UITableViewDelegate {

}

extension RoomsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    4
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell")!
    var config = UIListContentConfiguration.cell()
    config.text = "hossam"
    cell.contentConfiguration = config


    return cell
  }


}
