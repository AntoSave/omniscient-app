//
//  controlPanelController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 25/06/22.
//

import Foundation


class controlPanelController: UITableViewController {
    
    var state_armed: Bool = false

    @IBOutlet weak var stateColor: UIView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var imageState: UIImageView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var stateSwitch: UISwitch!
    
    @IBOutlet weak var sectionOne: UIView!
    @IBOutlet weak var sectionTwo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        navigationItem.title = "Settings"
        
        stateColor.layer.cornerRadius = min(stateColor.frame.size.height, stateColor.frame.size.width) / 2.0
        stateColor.clipsToBounds = true
        
        sectionOne.layer.cornerRadius = 20
        sectionTwo.layer.cornerRadius = 20
        //Inizializzo il sistema al valore corrente
        self.setState(value: self.getState())
        
    }
    
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if( sender.isOn ){
            self.setState(value: true)
        }else {
            self.setState(value: false)
        }
        
    }
    
    func getState() -> Bool {
        return state_armed
    }
    
    func setState(value: Bool){
        let old_state = state_armed
        state_armed = value
        
        if(state_armed == true){
            stateColor.backgroundColor = .green
            imageState.image = UIImage(named: "close-lock")
            
            firstLabel.text = "The system is ARMED"
            secondLabel.text = "On"
            stateSwitch.setOn(true, animated: true)
            stateSwitch.onTintColor = .green
        }
        
        if(state_armed == false){
            stateColor.backgroundColor = .red
            imageState.image = UIImage(named: "open-lock")
            
            firstLabel.text = "The system is DISARMED"
            secondLabel.text = "Off"
            stateSwitch.setOn(false, animated: true)
            stateSwitch.onTintColor = .red
        }
    }
    
    
}

