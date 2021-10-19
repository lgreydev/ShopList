//
//  ShopListTableViewController.swift
//  ShoppingList
//
//  Created by Sergey Lukaschuk on 14.10.2021.
//

import UIKit

class ShopListTableViewController: UITableViewController {

    // MARK: Constants
    let listToUsers = "ListToUsers"
    
    // MARK: Properties
    var items: [ShopListItem] = []
    var user: User?
    var onlineUserCount = UIBarButtonItem()
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        onlineUserCount = UIBarButtonItem(
          title: "1",
          style: .plain,
          target: self,
          action: #selector(onlineUserCountDidTouch))
        onlineUserCount.tintColor = .white
        navigationItem.leftBarButtonItem = onlineUserCount
        user = User(uid: "FakeId", email: "hungry@person.food")
    }
    
    @objc func onlineUserCountDidTouch() {
      performSegue(withIdentifier: listToUsers, sender: nil)
    }
}
