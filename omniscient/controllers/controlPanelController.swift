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
    @IBOutlet weak var sirenView: UIView!
    @IBOutlet weak var sirenLabel: UILabel!
    @IBOutlet weak var sirenImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        navigationItem.title = "Settings"
        
        stateColor.layer.cornerRadius = min(stateColor.frame.size.height, stateColor.frame.size.width) / 2.0
        stateColor.clipsToBounds = true
        
        sectionOne.layer.cornerRadius = 20
        sirenView.layer.cornerRadius = 20
        //Inizializzo il sistema al valore corrente
        self.setState(value: self.getState())
        self.initializeAlarm()
    }
    
    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name.logout, object: nil)
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
            secondLabel.text = "Armed"
            stateSwitch.setOn(true, animated: true)
            stateSwitch.onTintColor = .green
        }
        
        if(state_armed == false){
            stateColor.backgroundColor = .red
            imageState.image = UIImage(named: "open-lock")
            
            firstLabel.text = "The system is DISARMED"
            secondLabel.text = "Disarmed"
            stateSwitch.setOn(false, animated: true)
            stateSwitch.onTintColor = .red
        }
        
    }
    func initializeAlarm() {
        sirenImage.image =  UIImage(named: "siren")
        sirenLabel.text = "siren"
    }
    
    
}

