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


class RoomController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout   {
    @IBOutlet weak var roomCollectionView: UICollectionView!
    var room: Room?
    
    let context = PersistanceController.shared.container.viewContext
    var sensorList: [Sensor] {
        /*let fetchRequest = Sensor.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "room == %@", room!
        )
        print(room!)
        let sensors = try! context.fetch(fetchRequest)*/
        print("sensorList requested")
        //print(room!)
        //print(room!.sensors)
        let sensors = room?.sensors?.allObjects as! [Sensor]
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
        let sensor = sensorList[indexPath.row]
        
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
    var sensor: Sensor?
    var nomeSensore: String = ""
    var defaultValueSensor: Double = 0.0
    var state: FetchedState? {
        return StateModel.shared.current_state
    }
    
    func initialize(sensor: Sensor) {
        //Qui viene definito il template del analogView
        
        analogView.layer.cornerRadius = 12
        self.sensor=sensor
        self.setNameSensor(nameSensor: sensor.name ?? "")
        
        if sensor.type == "TEMPERATURE"{
            //Da inserire la query
            defaultValueSensor = 30.0
            self.setRate(currentRate: defaultValueSensor)
            self.setInfoSensor(info: String(Int(defaultValueSensor)) + " °C")
            self.setMaxValue(maxValue: 37)
            self.setStartColor(color: UIColor.link)
            self.setEndColor(color: UIColor.systemRed)
            self.setBgColor(color: UIColor.yellow)
        }else if sensor.type == "LIGHT" {
            
            //Da inserire la query
            defaultValueSensor = 400.0
            self.setRate(currentRate: defaultValueSensor)
            self.setInfoSensor(info: String(Int(defaultValueSensor)) + "  lx")
            
            self.setMaxValue(maxValue: 700)
            self.setStartColor(color: UIColor.link)
            self.setEndColor(color: UIColor.systemRed)
            self.setBgColor(color: UIColor.yellow)
        }else{
            //Sensore sconosciuto di cui non si sa nulla
            self.setRate(currentRate: defaultValueSensor)
            self.setInfoSensor(info: String(Int(defaultValueSensor)))
            self.setMaxValue(maxValue: 100)
            self.setStartColor(color: UIColor.link)
            self.setEndColor(color: UIColor.systemRed)
            self.setBgColor(color: UIColor.yellow)
        }
        
        
    }
    
    func setMaxValue(maxValue: Double){
        barIndicator.maxValue = CGFloat(maxValue)
    }
    func setRate(currentRate: Double){
        barIndicator.rate = CGFloat(currentRate)
    }
    func setStartColor(color: UIColor){
        barIndicator.startColor = color
    }
    func setEndColor(color: UIColor){
        barIndicator.endColor = color
    }
    func setBgColor(color: UIColor){
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
    
    func setDisabled(){
        self.isUserInteractionEnabled=false
        self.contentView.alpha = 0.2
    }
    
    func setEnabled(){
        self.isUserInteractionEnabled=true
        self.contentView.alpha = 1
    }
    
    @objc func updateUI(notification: Notification){
        let sensorID = (sensor?.remoteID)!
        if state == nil || state?.sensor_status[sensorID] == nil {
            self.setDisabled()
            return
        }
        
        let status = state?.sensor_status[sensorID]?.status
        if status != "ENABLED" {
            self.setDisabled()
            return
        }
        self.setEnabled()
        //Nota: do per scontato che i dati analogici ci siano!
        let data = state?.analog_sensor_data[sensorID]?.data
        if data == nil || data?.count == 0 {
            return
        }
        self.setRate(currentRate: data![0].value)
        self.setInfoSensor(info: String(data![0].value))
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUI(notification:)), name: NSNotification.Name.stateChanged, object: nil)
        print("awakeFromNib")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
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
