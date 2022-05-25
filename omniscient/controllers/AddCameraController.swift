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
    
    override func viewDidLoad() {
        var menuItems: [UIAction] {
            return [
                UIAction(title: "Camera da letto", handler: { (_) in
                }),
                UIAction(title: "Cucina", handler: { (_) in
                }),
                UIAction(title: "Aggiungi stanza...",handler: { (_) in
                    
                })
            ]
        }
        var roomMenu: UIMenu {
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        }
        roomButton.menu = roomMenu
        //roomButton.showsMenuAsPrimaryAction = true
        roomButton.changesSelectionAsPrimaryAction = true
        
    }
}
