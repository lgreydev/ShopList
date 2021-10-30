//
//  OnlineUsersTableViewController.swift
//  ShoppingList
//
//  Created by Sergey Lukaschuk on 15.10.2021.
//

import UIKit

class OnlineUsersTableViewController: UITableViewController {
    
    // MARK: Constants
    private let userCell = "UserCell"

    // MARK: Properties
    private var currentUsers: [String] = []

    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUsers.append("my_test@user")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(true)
    }
    
    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return currentUsers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
      let onlineUserEmail = currentUsers[indexPath.row]
      cell.textLabel?.text = onlineUserEmail
      return cell
    }
    
    // MARK: Actions
    @IBAction func signOutDidTouch(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
