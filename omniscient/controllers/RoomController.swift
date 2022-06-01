//
//  RoomController.swift
//  omniscient
//
//  Created by Antonio Langella on 27/05/22.
//

import UIKit
import CoreData
import GaugeKit


enum sensorType: String {
    case MOVEMENT,TEMPERATURE,LIGHT,DOOR,WINDOW
}


class RoomController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    //UICollectionViewDelegateFlowLayout va messo perchè è una collection view
    
    @IBOutlet weak var roomCollectionView: UICollectionView!
    
    let context = PersistanceController.shared.container.viewContext
    var sensorList: [Sensor] {
        let fetchRequest = Sensor.fetchRequest()
        let sensors = try! context.fetch(fetchRequest)
        return sensors
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        roomCollectionView.dataSource = self
        roomCollectionView.delegate = self
        roomCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    //Numero di Item che devono essere mostrati a video
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sensorList.count
    }
    
    //Configuro quale cella della collectionView deve essere mostrata
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var sensor = sensorList[indexPath.row]
        
        if sensor.type! == "TEMPERATURE" || sensor.type! == "LIGHT" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "analogTableCell", for: indexPath) as! AnalogTableCell
            cell.initialize(sensor: sensor)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "digitalTableCell", for: indexPath) as! DigitalTableCell
            cell.initialize(sensor: sensor)
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
        print(sensorList[indexPath.row].name ?? "Sensore sconosciuto")
        
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
    @IBOutlet weak var barIndicator: Gauge! // bar nel senso di barra circolare!!!
    
    var nomeSensore: String = ""
    var defaultValueSensor: Int = 0
    
    
    func initialize(sensor: Sensor) {
        //Qui viene definito il template del analogView
        analogView.layer.cornerRadius = 12
        
        self.setNameSensor(nameSensor: sensor.name ?? "")
        
        if sensor.type == "TEMPERATURE"{
            
            //Da inserire la query
            defaultValueSensor = 30
            self.rate(currentRate: defaultValueSensor)
            self.setInfoSensor(info: String(defaultValueSensor) + " °C")
            
            
            self.maxValue(maxValue: 37)
            self.startColor(color: UIColor.link)
            self.endColor(color: UIColor.systemRed)
            self.bgColor(color: UIColor.yellow)
        }else if sensor.type == "LIGHT" {
            
            //Da inserire la query
            defaultValueSensor = 400
            self.rate(currentRate: defaultValueSensor)
            self.setInfoSensor(info: String(defaultValueSensor) + "  lx")
            
            self.maxValue(maxValue: 700)
            self.startColor(color: UIColor.link)
            self.endColor(color: UIColor.systemRed)
            self.bgColor(color: UIColor.yellow)
        }else{
            //Sensore sconosciuto di cui non si sa nulla
            self.rate(currentRate: defaultValueSensor)
            self.setInfoSensor(info: String(defaultValueSensor))
            self.maxValue(maxValue: 100)
            self.startColor(color: UIColor.link)
            self.endColor(color: UIColor.systemRed)
            self.bgColor(color: UIColor.yellow)
        }
        
        
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
    
    func initialize(sensor: Sensor){
        //Qui viene definito il template del analogView
        digitalView.layer.cornerRadius = 12
        digitalIconImage.layer.cornerRadius = 12
        
        self.setNameSensor(nameSensor: sensor.name!)
    }
    
    func setNameSensor(nameSensor: String) {
        digitalSensor.text = nameSensor
        nomeSensore = nameSensor
    }
    
    func getNameSensor() -> String {
        return nomeSensore
    }
}
