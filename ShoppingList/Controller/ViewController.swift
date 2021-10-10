//
//  ViewController.swift
//  WorkingWithFirebase
//
//  Created by Sergey Lukaschuk on 08.10.2021.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    var model = Model.init()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func updateUI() {
        titleLabel.text = model.list[0].name
        descriptionLabel.text = model.list[0].notes
        
    }
    @IBAction func getData(_ sender: UIButton) {
        print(#line, "modelList", model.list.count)
        updateUI()
    }
}
