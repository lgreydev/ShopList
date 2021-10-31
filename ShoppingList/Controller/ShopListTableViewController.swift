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
    private let listToUsers = "ListToUsers"
    
    // MARK: Properties
    private var items: [ShopListItem] = []
    private var user: User?
    private var onlineUserCount = UIBarButtonItem()
    
    // MARK: Database
    private let ref = Database.database().reference(withPath: "shopList-items")
    private var refObservers: [DatabaseHandle] = []
    private var handle: AuthStateDidChangeListenerHandle?
    private let usersRef = Database.database().reference(withPath: "online")
    private var usersRefObservers: [DatabaseHandle] = []
    
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
        
        // Retrieving Data
        let completed = ref.queryOrdered(byChild: "completed").observe(.value) { snapshot in
            var newItems: [ShopListItem] = []
            for child in snapshot.children {
                if
                    let snapshot = child as? DataSnapshot,
                    let shopListItem = ShopListItem(snapshot: snapshot) {
                    newItems.append(shopListItem)
                }
            }
            self.items = newItems
            self.tableView.reloadData()
        }
        refObservers.append(completed)
        
        // Monitoring Users’ Online Status
        handle = Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else { return }
            self.user = User(authData: user)
            let currentUserRef = self.usersRef.child(user.uid)
            currentUserRef.setValue(user.email)
            currentUserRef.onDisconnectRemoveValue()
        }
        
        // Updating the Online User Count
        let users = usersRef.observe(.value) { snapshot in
          if snapshot.exists() {
            self.onlineUserCount.title = snapshot.childrenCount.description
          } else {
            self.onlineUserCount.title = "0"
          }
        }
        usersRefObservers.append(users)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        refObservers.forEach(ref.removeObserver(withHandle:))
        refObservers = []
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
        
        // This removes associated observers on 'usersRef'
        usersRefObservers.forEach(usersRef.removeObserver(withHandle:))
        usersRefObservers = []
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
        // Removing items from the table view
        if editingStyle == .delete {
            let shopListItem = items[indexPath.row]
            shopListItem.ref?.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Checking Off Items
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let shopListItem = items[indexPath.row]
        let toggledCompletion = !shopListItem.completed
        toggleCellCheckbox(cell, isCompleted: toggledCompletion)
        shopListItem.ref?.updateChildValues([
            "completed": toggledCompletion
        ])
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
            
            let shopListItemRef = self.ref.child(text.lowercased())
            shopListItemRef.setValue(shopListItem.toAnyObject())
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
