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
        
        /*print("ESEGUO LA FETCH DEI SENSORI")
        var fetchRequest = Sensor.fetchRequest()
        var result = try! context.fetch(fetchRequest)
        print((result)[0].room as! Room)
        print((result)[0].room?.sensors?.allObjects)*/
    }


}

