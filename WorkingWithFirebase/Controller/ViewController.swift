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
        updateUI()
        
    }
    
    func updateUI() {
        model.getData()
        titleLabel.text = model.list[0].name
        descriptionLabel.text = model.list[0].notes
        
    }
}
