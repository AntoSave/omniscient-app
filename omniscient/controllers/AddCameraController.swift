//
//  AddCameraController.swift
//  omniscient
//
//  Created by Antonio Langella on 30/04/22.
//

import Foundation

class AddCameraController: UIViewController{
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var DomainTextField: UITextField!
    @IBOutlet weak var PortTextField: UITextField!
    @IBOutlet weak var roomButton: UIButton!
    let context = PersistanceController.shared.container.viewContext
    var menuItems: [UIAction] {
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
    
    
    override func viewDidLoad() {
        let roomMenu: UIMenu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        roomButton.menu = roomMenu
        //roomButton.showsMenuAsPrimaryAction = true
        roomButton.changesSelectionAsPrimaryAction = true
        
    }
}
