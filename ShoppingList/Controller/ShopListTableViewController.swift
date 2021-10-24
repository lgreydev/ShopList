//
//  ShopListTableViewController.swift
//  ShoppingList
//
//  Created by Sergey Lukaschuk on 14.10.2021.
//

import UIKit
import Firebase

class ShopListTableViewController: UITableViewController {

    // MARK: Constants
    let listToUsers = "ListToUsers"
    
    // MARK: Properties
    var items: [ShopListItem] = []
    var user: User?
    var onlineUserCount = UIBarButtonItem()
    
    // MARK: Database
    let ref = Database.database().reference(withPath: "shopList-items")
    var refObservers: [DatabaseHandle] = []
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsMultipleSelectionDuringEditing = false
        
        onlineUserCount = UIBarButtonItem(
          title: "Online",
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
      let shopListItem = items[indexPath.row]

      cell.textLabel?.text = shopListItem.name
      cell.detailTextLabel?.text = shopListItem.addedByUser

      toggleCellCheckbox(cell, isCompleted: shopListItem.completed)

      return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
      return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        items.remove(at: indexPath.row)
        tableView.reloadData()
      }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let cell = tableView.cellForRow(at: indexPath) else { return }
      var groceryItem = items[indexPath.row]
      let toggledCompletion = !groceryItem.completed

      toggleCellCheckbox(cell, isCompleted: toggledCompletion)
      groceryItem.completed = toggledCompletion
      tableView.reloadData()
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
    
    // MARK: IBActions Add Item
    @IBAction func addItemDidTouch(_ sender: AnyObject) {
        let alert = UIAlertController(
          title: "Shop List Item",
          message: "Add an Item",
          preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
          guard
            let textField = alert.textFields?.first,
            let text = textField.text,
            let user = self.user
          else { return }

          let shopListItem = ShopListItem(
            name: text,
            addedByUser: user.email,
            completed: false)

          self.items.append(shopListItem)
          self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(
          title: "Cancel",
          style: .cancel)

        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
}
