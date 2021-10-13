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
                    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Actions
    @IBAction func loginDidTouch(_ sender: Any) {
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
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
