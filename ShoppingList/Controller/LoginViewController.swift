//
//  LoginViewController.swift
//  ShoppingList
//
//  Created by Sergey Lukaschuk on 13.10.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var enterEmail: UITextField!
    @IBOutlet weak var enterPassword: UITextField!
    
    // MARK: Constants
    private let loginToList = "ListToUsers"
    
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
        guard
          let email = enterEmail.text,
          let password = enterPassword.text,
          !email.isEmpty,
          !password.isEmpty
        else { return }
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
          if error == nil {
            Auth.auth().signIn(withEmail: email, password: password)
          } else {
            print("Error in createUser: \(error?.localizedDescription ?? "")")
          }
        }
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
