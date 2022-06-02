//
//  AddCameraController.swift
//  omniscient
//
//  Created by Antonio Langella on 30/04/22.
//

import Foundation

class AddCameraController: UITableViewController{
    let context = PersistanceController.shared.container.viewContext
    var roomMenuItems: [UIAction] {
        let fetchRequest = Room.fetchRequest()
        let rooms = try! context.fetch(fetchRequest)
        return rooms.map(){ room in
            return UIAction(title: room.name!, handler: { _ in
                
            })
        }
        /*return [
            UIAction(title: "Camera da letto", handler: { (_) in
            }),
            UIAction(title: "Cucina", handler: { (_) in
            }),
            UIAction(title: "Aggiungi stanza...",handler: { (_) in
                
            })
        ]*/
    }
    
    let content = [
        ["type":"InputText","for":"Nome Telecamera"],
        ["type":"InputText","for":"Dominio"],
        ["type":"InputText","for":"Porta"],
        ["type":"InputText","for":"Nome Utente"],
        ["type":"InputText","for":"Password"],
        ["type":"Button","for":"Room"]
    ]
    var values: [String:()->String] = [:]
    
    override func viewDidLoad() {
        
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        for x in values{
            print(x.key,x.value())
        }
        let cameraName = values["Nome Telecamera"]!()
        let roomName = values["Room"]!()
        let domain = values["Dominio"]!()
        let port = values["Porta"]!()
        let username = values["Nome Utente"]!()
        let password = values["Password"]!()
        APIHelper.createCamera(cameraName: cameraName, roomName: roomName, domain: domain, port: port, username: username, password: password){
            result in
            switch(result){
            case(.success(let s)):
                let camera = Camera(context:self.context)
                camera.name=cameraName
                camera.port=Int16(port)!
                camera.domain=domain
                if username != ""{
                    camera.username = username
                }
                if password != ""{
                    camera.password = password
                }
                let fetchRequest = Room.fetchRequest()
                fetchRequest.predicate=NSPredicate(format: "name like %@", roomName)
                let room = try! self.context.fetch(fetchRequest).first
                camera.composition = room
                
            case(.failure(let e)):
                print("Errore",e)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = self.content[indexPath.row]
        switch (content["type"]!){
        case "InputText":
            let cell: InputTextTableCell = self.tableView.dequeueReusableCell(withIdentifier: "inputTextCell", for: indexPath) as! InputTextTableCell
            cell.initialize(for: content["for"]!)
            values.updateValue(cell.getText, forKey: content["for"]!)
            return cell
        //case "Button":
        default:
            let cell: ButtonTableCell = self.tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableCell
            let roomMenu: UIMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: roomMenuItems)
            cell.initialize(for: "Room",menu:roomMenu)
            values.updateValue(cell.getSelectedItem, forKey: content["for"]!)
            return cell
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
}

class InputTextTableCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var box: UIView!
    func initialize(for f: String){
        label.text = f
        box.layer.cornerRadius = 10
    }
    func getText() -> String{
        return textField.text!
    }
}

class ButtonTableCell: UITableViewCell{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    var menu: UIMenu?
    func initialize(for f: String,menu: UIMenu){
        label.text=f
        self.menu = menu
        button.menu = menu
        //roomButton.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
    }
    func getSelectedItem() -> String{
        return (button.titleLabel?.text)!
    }
}
