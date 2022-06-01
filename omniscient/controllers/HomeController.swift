//
//  HomeController.swift
//  omniscient
//
//  Created by Antonio Langella on 27/05/22.
//
import UIKit
import CoreData

class HomeController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var HomeTableView: UITableView!
    @IBOutlet var HomeView: UIView!

    let context = PersistanceController.shared.container.viewContext
    var roomList: [Room] {
        let fetchRequest = Room.fetchRequest()
        let rooms = try! context.fetch(fetchRequest)
        return rooms
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.HomeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        HomeTableView.dataSource = self
        HomeTableView.delegate = self
    }
    
    //Definisco il numero di sezioni TODO: il numero deve essere determinato dinamicamente
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Definisco il numero di celle per sezione
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomList.count
    }
    
    //Funzione chiamata prima del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let roomControllerVC = segue.destination as? RoomController {


        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RoomTableCell = self.HomeTableView.dequeueReusableCell(withIdentifier: "RoomIdentifier", for: indexPath) as! RoomTableCell
        
        //Inizializza le celle della tableView
        var room = roomList[indexPath.row]
        cell.initialize(room: room)
        
        
        
        return cell
    }
    
}


class RoomTableCell: UITableViewCell {
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    func initialize(room: Room) {
        //Qui viene definito il template delle celle
        cellView.layer.cornerRadius = 20
        
        //Prelevare i dati da CoreData
        self.setRoomTitle(roomTitle: room.name!)
        self.setBackgroundColor(color: .cyan)
        
    }
    
    //Personalizzazione delle celle
    public func setRoomTitle(roomTitle: String){
        self.roomTitle.text = roomTitle
    }
    public func setBackgroundColor(color: UIColor){
        cellView.backgroundColor = color
    }
    
}
