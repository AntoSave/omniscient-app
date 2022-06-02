//
//  AddRoomController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 31/05/22.
//

import Foundation
import UIKit

class AddRoomController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var nameRoomTextField: UITextField!
    @IBOutlet weak var selectedColorView: UIView!
    
    var color = UIColor(.white)
    var nameRoom: String = ""
    
    let context = PersistanceController.shared.container.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSelectedColorView()
    }
    
    
    @IBAction func colorButton(_ sender: Any) {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.isModalInPresentation = true//Non si può swipare questa schermata
        present(colorPickerVC, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        color = viewController.selectedColor
        selectedColorView.backgroundColor = color
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        color = viewController.selectedColor
    }
    
    @IBAction func saveButton(_ sender: Any) {
        self.nameRoom = getNameRoomTextField()
        print("********************")
        print(self.nameRoom)
        print("********************")
        if(self.nameRoom != ""){
            let r = Room(context: context)
            r.name = self.nameRoom
            try! context.save()
            //TODO: sto salvando una stanza
            self.nameRoom = ""
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    func initializeSelectedColorView(){
        selectedColorView.layer.borderWidth = 3
        selectedColorView.layer.borderColor = UIColor.black.cgColor
        selectedColorView.layer.cornerRadius = 25
    }
    
    func getNameRoomTextField() -> String {
        return nameRoomTextField.text ?? ""
    }
    
}
