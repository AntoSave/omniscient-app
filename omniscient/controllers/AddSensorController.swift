//
//  AddSensorController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 29/05/22.
//

import UIKit


class AddSensorController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var generalView: UIView!
    @IBOutlet weak var SensorTableView: UITableView!
    
    let context = PersistanceController.shared.container.viewContext
    
    var roomMenuItems: [UIAction] {
        let fetchRequest = Room.fetchRequest()
        let rooms = try! context.fetch(fetchRequest)
        return rooms.map(){ room in
            return UIAction(title: room.name!, handler: { _ in
                
            })
        }
    }
    
    let content = [
        ["type":"InputText","for":"ID"],
        ["type":"InputText","for":"Name"],
        ["type":"InputText","for":"Type"],
        ["type":"InputText","for":"Nome Utente"],
        //["type":"InputText","for":"Password"],
        ["type":"Button","for":"Room"]
    ]
    var values: [String:()->String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SensorTableView.separatorStyle = UITableViewCell.SeparatorStyle.none //Toglie il separatore (divider)
        self.SensorTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        SensorTableView.dataSource = self
        SensorTableView.delegate = self
    }
    
    @IBAction func onSave(_ sender: Any) {
        //TODO: integrare l'onSave col backend
//        for x in values{
//            print(x.key,x.value())
//        }
//        let cameraName = values["Nome Telecamera"]!()
//        let roomName = values["Room"]!()
//        let domain = values["Dominio"]!()
//        let port = values["Porta"]!()
//        if Int16(port) == nil{
//            return
//        }
//        let username = values["Nome Utente"]!()
//        let password = values["Password"]!()
//        APIHelper.createCamera(cameraName: cameraName, roomName: roomName, domain: domain, port: port, username: username, password: password){
//            result in
//            switch(result){
//            case(.success(let s)):
//                let camera = Camera(context:self.context)
//                camera.name=cameraName
//                camera.port=Int16(port)!
//                camera.domain=domain
//                if username != ""{
//                    camera.username = username
//                }
//                if password != ""{
//                    camera.password = password
//                }
//                let fetchRequest = Room.fetchRequest()
//                fetchRequest.predicate=NSPredicate(format: "name like %@", roomName)
//                let room = try! self.context.fetch(fetchRequest).first
//                camera.composition = room
//                try! self.context.save()
//                DispatchQueue.main.async {
//                    self.navigationController!.popViewController(animated: true)
//                    NotificationCenter.default.post(name: NSNotification.Name.staticDataUpdated, object: nil)
//                }
//            case(.failure(let e)):
//                print("Errore",e)
//            }
//        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = self.content[indexPath.row]
        switch (content["type"]!){
        case "InputText":
            let cell: SensorInputTextTableCell = self.SensorTableView.dequeueReusableCell(withIdentifier: "sensorInputTextTableCell", for: indexPath) as! SensorInputTextTableCell
            cell.initialize(for: content["for"]!)
            values.updateValue(cell.getText, forKey: content["for"]!)
            return cell
        //case "Button":
        default:
            let cell: SensorButtonTableCell = self.SensorTableView.dequeueReusableCell(withIdentifier: "sensorButtonTableCell", for: indexPath) as! SensorButtonTableCell
            let roomMenu: UIMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: roomMenuItems)
            cell.initialize(for: "Room",menu:roomMenu)
            values.updateValue(cell.getSelectedItem, forKey: content["for"]!)
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
}

class SensorInputTextTableCell: UITableViewCell{
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    func initialize(for f: String){
        label.text = f
        boxView.layer.cornerRadius = 10
    }
    func getText() -> String{
        return textField.text!
    }
}

class SensorButtonTableCell: UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    var menu: UIMenu?
    func initialize(for f: String,menu: UIMenu){
        label.text = f
        self.menu = menu
        button.menu = menu
        //roomButton.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
    }
    func getSelectedItem() -> String{
        return (button.titleLabel?.text)!
    }
}
