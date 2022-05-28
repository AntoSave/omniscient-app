//
//  RoomController.swift
//  omniscient
//
//  Created by Antonio Langella on 27/05/22.
//

import UIKit
import CoreData

//Ho una variabile room nel CoreData

//struct Sensor {
//    let titleSensor: String
//    let info: String
//}

class RoomController: UIViewController /*, UICollectionViewDataSource, UICollectionViewDelegate  */ {
    
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
//    let sensors: [Sensor] = [
//        Sensor(titleSensor: "Sensore di Temperatura", info: "30 Gradi"),
//        Sensor(titleSensor: "Sensore di Movimento", info: "No Movement"),
//        Sensor(titleSensor: "Sensore di Luce", info: "400 lux"),
//        Sensor(titleSensor: "Sensore di Porta", info: "closed")
//    ]
        
    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        roomCollectionView.dataSource = self
////        roomCollectionView.delegate = self
//    }
//
//    //Numero di Item per ogni sezione
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    //Numero di celle per oggetto
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
}

class SensorTableCell: UICollectionViewCell  { //nota: provare prima con CollectionView UITableViewCell
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
}
