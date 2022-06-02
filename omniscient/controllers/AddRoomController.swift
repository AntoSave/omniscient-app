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
        let roomName = getNameRoomTextField()
        if roomName == "" { 
            let alert = UIAlertController(title: nil, message: "You must insert a room name", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        APIHelper.createRoom(roomName: roomName){
            result in
            switch(result){
            case(.success(let s)):
                let room = Room(context:self.context)
                room.name=roomName
                try! self.context.save()
                DispatchQueue.main.async {
                    self.navigationController!.popViewController(animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name.staticDataUpdated, object: nil)
                }
            case(.failure(let e)):
                print("Errore",e)
            }
        }
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
