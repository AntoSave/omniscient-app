//
//  MainController.swift
//  omniscient
//
//  Created by Antonio Langella on 24/04/22.
//

import UIKit

class MainController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var cameraTableView: UITableView!
    let cellReuseIdentifier = "cameraCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.cameraTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cameraTableView.dataSource = self
        cameraTableView.delegate = self
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CameraCell = self.cameraTableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! CameraCell
           
           // Configure the cell’s contents.
           cell.textLabel!.text = "Cell text"
           return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
        }
    
}

class CameraCell: UITableViewCell{
    
}
