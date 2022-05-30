//
//  StateModel.swift
//  omniscient
//
//  Created by Antonio Langella on 28/05/22.
//

import Foundation

/*class StateModel {
    //static let shared: StateModel = StateModel()
    /*
     Contiene lo stato di tutti i sensori analogici.
     La chiave è l'id del sensore.
     Il valore è un array che  contiene n tuple nel formato (tempo,valore_letto)
     */
    let analogSensors: Dictionary<String,[(Int,Double)]>
    /*
     Contiene lo stato di tutti i sensori porte/finestre.
     La chiave è l'id del sensore.
     Il valore è True se aperta e False se chiusa
     */
    let doorSensors: Dictionary<String,Bool>
    /*
     Contiene lo stato di tutti i sensori di movimento.
     La chiave è l'id del sensore.
     Il valore è un array che contiene i tempi degli ultimi movimenti
     */
    let movementSensors: Dictionary<String,[Int]>
}*/
