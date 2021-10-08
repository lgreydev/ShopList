//
//  ViewController.swift
//  WorkingWithFirebase
//
//  Created by Sergey Lukaschuk on 08.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var model = Model()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = model.list[0].name
        descriptionLabel.text = model.list[0].notes
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
