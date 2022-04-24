//
//  MainController.swift
//  omniscient
//
//  Created by Antonio Langella on 24/04/22.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myLabel.text = "Ciao Mondo"
    }


}
