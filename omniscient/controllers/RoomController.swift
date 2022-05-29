//
//  RoomController.swift
//  omniscient
//
//  Created by Antonio Langella on 27/05/22.
//

import UIKit
import CoreData
import GaugeKit

//Ho una variabile room nel CoreData
enum sensorCategory {
    case analog
    case digital
}

enum sensorType {
    case movement
    case temperature
    case light
    case door
    case window
}

struct MySensor {
    let nameSensor: String
    let info: String
    let category: sensorCategory
    let type: sensorType
}

let mySensors: [MySensor] = [
    MySensor(nameSensor: "Temperatura", info: "30",category: .analog, type: .temperature),
    MySensor(nameSensor: "Movimento", info: "No Movement",category: .digital, type: .movement),
    MySensor(nameSensor: "Luce", info: "400",category: .analog, type: .light),
    MySensor(nameSensor: "Porta", info: "closed", category: .digital, type: .door)
]

class RoomController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout   {
    
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        roomCollectionView.dataSource = self
        roomCollectionView.delegate = self
        roomCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    //Numero di Item che devono essere mostrati a video
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mySensors.count
    }
    
    //Configuro quale cella della collectionView deve essere mostrata
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sensor =  mySensors[indexPath.row]
        
        if sensor.category == .analog {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "analogTableCell", for: indexPath) as! AnalogTableCell
            
            cell.initialize()
            cell.setNameSensor(nameSensor: sensor.nameSensor)
            
            cell.rate(currentRate: Int(sensor.info) ?? 0)
            
            
            
            if sensor.type == .temperature{
                cell.setInfoSensor(info: sensor.info + "°C")
                cell.maxValue(maxValue: 37)
                cell.startColor(color: UIColor.link)
                cell.endColor(color: UIColor.systemRed)
                cell.bgColor(color: UIColor.yellow)
            }else if sensor.type == .light {
                cell.setInfoSensor(info: sensor.info + " lx")
                cell.maxValue(maxValue: 700)
                cell.startColor(color: UIColor.link)
                cell.endColor(color: UIColor.systemRed)
                cell.bgColor(color: UIColor.yellow)
            }
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "digitalTableCell", for: indexPath) as! DigitalTableCell
            cell.initialize()
            cell.setNameSensor(nameSensor: sensor.nameSensor)
            return cell
            
        }
            
    }
    
    //Questa funzione mi permette effettivamente di scegliere il layout fornendo le dimensioni delle celle della CollectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Agendo qui è possibile adattare la Collection ad esempio mettendo la possibilità di scrollare a destra.
        return CGSize(width: 202, height: 211)
        
    }
    
    //Cliccare qui equivale a svolgere delle azioni quando viene premuta una determinata cella
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(mySensors[indexPath.row].nameSensor)
        
    }
    
    //Funzione chiamata prima del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(sender)
        var titleSensor: String = ""
        if let analogTableCell = sender as? AnalogTableCell {
            titleSensor = analogTableCell.getNameSensor()
        }
        
        if let analogChartController = segue.destination as? AnalogChartController {
            analogChartController.setTitle(title: titleSensor)
        }
        
        if let digitalTableCell = sender as? DigitalTableCell {
            titleSensor = digitalTableCell.getNameSensor()
        }
        
        if let digitalChartController = segue.destination as? DigitalChartController {
            digitalChartController.setTitle(title: titleSensor)
        }
    }
    
}

class AnalogTableCell: UICollectionViewCell  { //nota: provare prima con CollectionView UITableViewCell
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var analogView: UIView!
    @IBOutlet weak var barIndicator: Gauge!
    
    var nomeSensore: String = ""
    
    func initialize() {
        //Qui viene definito il template del analogView
        analogView.layer.cornerRadius = 12
    }
    
    func maxValue(maxValue: Int){
        barIndicator.maxValue = CGFloat(maxValue)
    }
    func rate(currentRate: Int){
        barIndicator.rate = CGFloat(currentRate)
    }
    func startColor(color: UIColor){
        barIndicator.startColor = color
    }
    func endColor(color: UIColor){
        barIndicator.endColor = color
    }
    func bgColor(color: UIColor){
        barIndicator.bgColor = color
    }

    func setNameSensor(nameSensor: String) {
        titleLabel.text = nameSensor
        nomeSensore = nameSensor
    }
    func setInfoSensor(info: String) {
        infoLabel.text = info
    }
    
    func getNameSensor() -> String {
        return nomeSensore
    }
    
}

class DigitalTableCell: UICollectionViewCell  {
    @IBOutlet weak var digitalSensor: UILabel!
    @IBOutlet weak var digitalIconImage: UIImageView!
    @IBOutlet weak var digitalView: UIView!
    
    var nomeSensore: String = ""
    
    func initialize() {
        //Qui viene definito il template del analogView
        digitalView.layer.cornerRadius = 12
        digitalIconImage.layer.cornerRadius = 12
    }
    
    func setNameSensor(nameSensor: String) {
        digitalSensor.text = nameSensor
        nomeSensore = nameSensor
    }
    
    func getNameSensor() -> String {
        return nomeSensore
    }
}
