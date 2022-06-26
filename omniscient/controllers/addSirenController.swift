//
//  addSirenController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 26/06/22.
//

import UIKit


class AddSirenController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var generalView: UIView!
    @IBOutlet weak var addSirenTableView: UITableView!
    
    let content = ["ID","Name"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSirenTableView.separatorStyle = UITableViewCell.SeparatorStyle.none //Toglie il separatore (divider)
        self.addSirenTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        addSirenTableView.dataSource = self
        addSirenTableView.delegate = self
    }
    
    @IBAction func onSave(_ sender: Any) {
        //TODO: integrare l'onSave col backend

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: SirenInputTextTableCell = self.addSirenTableView.dequeueReusableCell(withIdentifier: "sirenInputTextTableCell", for: indexPath) as! SirenInputTextTableCell
        
        let name: String = content[indexPath.row]
        cell.initialize(f: name)
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
}

class SirenInputTextTableCell: UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var boxView: UIView!
    
    
    func initialize(f: String){
        label.text = f
        boxView.layer.cornerRadius = 10
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
    }
    func getText() -> String{
        return textfield.text!
    }
}

