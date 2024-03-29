//
//  SettingsStoryboardController.swift
//  omniscient
//
//  Created by DAVIDE RISI on 24/04/22.
//

import UIKit

//Per creare questo tipo di strutture bisogna gestire due cose: 1) come creare/progettare le celle (La forma e la struttura) 2)come gestirle


//Creiamo la struttura delle sezioni di impostazioni
struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

//Creaiamo la struttura delle opzioni di settings
struct SettingsOption {
    let title: String
    let icon: UIImage? //è optional
    let iconBackgroundColor: UIColor
    let handler: ( ()-> Void )   //Ci dice come gestire l'opzione
}

class SettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        return table
    }()
    
    
    //creo un array immutabile di sezioni che contengono le varie opzioni delle impostazioni
    var models = [Section]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tabBarItem3 = self.tabBarController?.tabBar.items?[2] {
                    tabBarItem3.title = ""
                    tabBarItem3.image = UIImage(systemName: "gear")
                    tabBarItem3.selectedImage = UIImage(systemName: "gear")
                }
    
        
        //chiamo la funzione per configurare le varie opzioni delle impostazioni
        configure()
        navigationItem.title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let tableRect: CGRect = CGRect(x: 20, y: 44, width: 374, height: 769) //mi determina il rettangolo della table view
        tableView.frame = tableRect /*view.bounds*/ //Se mettto view.bounds diventa full screen
        tableView.layer.cornerRadius = 10  // regolo lo smussamento dei bordi
        tableView.separatorInset.left = 15 //regolo la linea di separazione
        
        tableView.clipsToBounds = true //cambiamenti impercettibili
        tableView.backgroundColor = .systemBackground //Colore della tableview
        
    }
    
    //Dispone i titoli delle sezioni definite nello schermo
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    //numero di sezioni della tableView. Li conto dinamicamente dall'array models
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    //numero di opzioni all'interno della sezione
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    //mostra l'array di opzioni che ho creato
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsTableViewCell.identifier,
                for: indexPath
            ) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .tertiarySystemFill // .secondarySystemFill //Setto il colore delle celle
//            cell.layer.cornerRadius = 10
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitchTableViewCell.identifier,
                for: indexPath
            ) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .tertiarySystemFill // .secondarySystemFill //Setto il colore delle celle
            cell.configure(with: model)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.top)
        let type = models[indexPath.section].options[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            print("You've selected an option")
            model.handler()
        case .switchCell(let model):
            print("You've selected a switch")
            model.handler()
        }
    }
//Non mi interessa quando viene deselezionata
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let type = models[indexPath.section].options[indexPath.row]
//        switch type.self {
//        case .staticCell(let model):
//            print("Deselected")
//            model.handler()
//        case .switchCell(let model):
//            print("Deselected")
//            model.handler()
//        }
//    }
    
    @objc func option1PushPressed(){
        if let navigationController = navigationController {
            let vc = Option1Controller()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    @objc func option1PopPressed(){
        if let navigationController = navigationController {
            let vc = Option1Controller()
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    
    //crea le varie impostazioni nella schermata
    func configure() {
        /*
        models.append(Section(title: "Nome",
                            options:
                                
                    [
                        .staticCell(model: SettingsOption(title: "Opzione 1", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemCyan){
                            print("Ora apro opzione 1")
                            self.option1PushPressed()
//                            let vc = Option1Controller()
//                            vc.title = "option 1"
//                            vc.navigationItem.largeTitleDisplayMode = .never
//                            //vc.navigationController?.pushViewController(vc, animated: true)
//                            self.navigationController?.pushViewController(vc, animated: true)
                            print("Fatto")
                            
                            
                        }),
                        .staticCell(model:SettingsOption(title: "Opzione 2", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemCyan){}),
                        .staticCell(model:SettingsOption(title: "Opzione 3", icon: UIImage(systemName: "gear"), iconBackgroundColor: .systemCyan){})
                    ]
                              
                              
                             ))
        */
        models.append(Section(title: "",
                            options:
                    [
                        .switchCell(model: SettingsSwitchOption(title: "Allarme", icon: UIImage(systemName: "house"), iconBackgroundColor: .systemRed, handler: {
                            
                        }, isOn: true)),
                    ]
                             ))
        
    }
}
