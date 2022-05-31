//
//  ViewController.swift
//  omniscient
//
//  Created by Antonio Langella on 20/04/22.
//

import UIKit

class ViewController: UITabBarController {
    let context = PersistanceController.shared.container.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PersistanceController.fetchStaticContent(context: context)
    }


}

