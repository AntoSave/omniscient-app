//
//  AddRoomController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 31/05/22.
//

import UIKit

var nameRoom: String = ""

class AddRoomController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var AddRoomTableView: UITableView!
    let context = PersistanceController.shared.container.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AddRoomTableView.separatorStyle = UITableViewCell.SeparatorStyle.none //Toglie il separatore (divider)
        self.AddRoomTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        AddRoomTableView.dataSource = self
        AddRoomTableView.delegate = self
    }
    
    //Definisco il numero di sezioni
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Definisco il numero di celle per sezione
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Definisco il titolo delle sezioni
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
            case 0:
                sectionName = NSLocalizedString("Nome Stanza", comment: "nome")
            case 1:
                sectionName = NSLocalizedString("Colore", comment: "myOtherSectionName")
            default:
                sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddRoomTableCell = self.AddRoomTableView.dequeueReusableCell(withIdentifier: "nomeNewRoomCell", for: indexPath) as! AddRoomTableCell
        cell.initialize()
        return cell
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        let r = Room(context: context)
//        r.name = nameRoomTextField.text
//    }
//
//    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        <#code#>
//    }

}

class AddRoomTableCell: UITableViewCell {
    
    @IBOutlet weak var nameRoomTextField: UITextField!
    @IBOutlet weak var addRoomCellView: UIView!
    func initialize() {
        //Qui viene definito il template delle celle
        addRoomCellView.layer.cornerRadius = 10
    }
    
    
}
