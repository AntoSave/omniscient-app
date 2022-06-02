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
        StateModel.shared.fetchState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
        AppUtility.lockOrientation(.portrait,andRotateTo: .portrait)
       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       AppUtility.lockOrientation(.portrait,andRotateTo: .portrait)
    }
}

