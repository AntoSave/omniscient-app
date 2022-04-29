//
//  MainController.swift
//  omniscient
//
//  Created by Antonio Langella on 24/04/22.
//

import UIKit

class CameraListController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var cameraTableView: UITableView!
    let cellReuseIdentifier = "cameraCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.cameraTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cameraTableView.dataSource = self
        cameraTableView.delegate = self
    }
    //Restituisce il numero di righe
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    //Funzione generatrice di righe
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CameraCell = self.cameraTableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! CameraCell
           
           // Configure the cell’s contents.
           cell.textLabel!.text = "Cell text"
           return cell
    }
    //Funzione chiamata al click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    //Funzione chiamata prima del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cameraVC = segue.destination as? CameraController {

            //cameraVC.link="ciao"
           }
    }
}
//Riga personalizzata
class CameraCell: UITableViewCell{
    
}
