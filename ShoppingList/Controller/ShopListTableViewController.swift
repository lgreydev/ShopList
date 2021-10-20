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
        user = User(uid: "FakeId", email: "user@email.com")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(true)
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(true)
    }
    
    // MARK: UITableView Delegate methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
      let groceryItem = items[indexPath.row]

      cell.textLabel?.text = groceryItem.name
      cell.detailTextLabel?.text = groceryItem.addedByUser

      toggleCellCheckbox(cell, isCompleted: groceryItem.completed)

      return cell
    }
    
    // MARK: Private Methods
    @objc private func onlineUserCountDidTouch() {
      performSegue(withIdentifier: listToUsers, sender: nil)
    }
    
    private func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
      if !isCompleted {
        cell.accessoryType = .none
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
      } else {
        cell.accessoryType = .checkmark
        cell.textLabel?.textColor = .gray
        cell.detailTextLabel?.textColor = .gray
      }
    }
}
