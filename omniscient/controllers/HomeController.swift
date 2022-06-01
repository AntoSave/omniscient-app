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
        self.HomeTableView.separatorStyle = UITableViewCell.SeparatorStyle.none //Toglie il separatore (divider)
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RoomTableCell = self.HomeTableView.dequeueReusableCell(withIdentifier: "RoomIdentifier", for: indexPath) as! RoomTableCell
        
        //Inizializza le celle della tableView
        let room = roomList[indexPath.row]
        cell.initialize(room: room)
        return cell
    }
    
    //Funzione chiamata prima del segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let roomControllerVC = segue.destination as? RoomController {
                

        }
    }
    
    
    //Gestione della cancellazione delle celle tramite il bottone edit
    @IBAction func DeleteButton(_ sender: Any) {
        if(HomeTableView.isEditing == false){
            HomeTableView.isEditing = true
        }else if (HomeTableView.isEditing == true){
            HomeTableView.isEditing = false
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .insert {
            HomeTableView.beginUpdates()
            
            //TODO: Implementare la cancellazione nel back-end
            let r = Room(context: context)
            r.name = "AJA"
            HomeTableView.insertRows(at: [indexPath], with: .fade)
            HomeTableView.endUpdates()
//            roomList.append(r)
//            roomList.insert(r, at: indexPath.row)
            HomeTableView.endUpdates()
        }
        
        if editingStyle == .delete {
            HomeTableView.beginUpdates()
            //TODO: Implementare la cancellazione nel back-end
            let room = roomList[indexPath.row]
            context.delete(room)
            HomeTableView.deleteRows(at: [indexPath], with: .fade)
            
//            HomeTableView.insertRows(at: [indexPath], with: .fade)
            HomeTableView.endUpdates()

        }
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
