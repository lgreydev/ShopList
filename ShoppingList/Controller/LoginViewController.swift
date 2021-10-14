//
//  LoginViewController.swift
//  ShoppingList
//
//  Created by Sergey Lukaschuk on 13.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    
    // MARK: Properties
    private let loginToList = "ListToUsers"
                    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        enterEmail.delegate = self
        enterPassword.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: Actions
    @IBAction func loginDidTouch(_ sender: Any) {
        performSegue(withIdentifier: loginToList, sender: nil)
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
        performSegue(withIdentifier: loginToList, sender: nil)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == enterEmail {
      enterPassword.becomeFirstResponder()
    }

    if textField == enterPassword {
      textField.resignFirstResponder()
    }
    return true
  }
}
