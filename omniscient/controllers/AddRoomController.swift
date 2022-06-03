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
    
    var color = UIColor(red: CGFloat(0.5), green: CGFloat(0.5), blue: CGFloat(0.5), alpha: CGFloat(1))//UIColor(.cyan)
    
    let context = PersistanceController.shared.container.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSelectedColorView()
        selectedColorView.backgroundColor = color
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
        if roomName == "" { //TODO: popup field errato "Devi inserire il nome"
            return
        }
        let ciColor = CIColor(color:color)
        APIHelper.createRoom(roomName: roomName,color: ciColor){
            result in
            switch(result){
            case(.success(let s)):
                let room = Room(context:self.context)
                room.name=roomName
                room.colorRed=Float(ciColor.red)
                room.colorGreen=Float(ciColor.green)
                room.colorBlue=Float(ciColor.blue)
                room.colorAlpha=Float(ciColor.alpha)
                try! self.context.save()
                DispatchQueue.main.async {
                    self.navigationController!.popViewController(animated: true)
                    NotificationCenter.default.post(name: NSNotification.Name.staticDataUpdated, object: nil)
                }
            case(.failure(let e)): //TODO: popup field errato "La camera già esiste"
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
