//
//  StateModel.swift
//  omniscient
//
//  Created by Antonio Langella on 28/05/22.
//

import Foundation

struct FetchedSensorStatus: Decodable {
    let id: String
    let status: String
}

struct FetchedAnalogDataPoint: Decodable{
    let time: Date
    let value: Double
}

struct FetchedDigitalDataPoint: Decodable{
    let time: Date
    let value: String
}

struct FetchedAnalogSensorData: Decodable {
    let id: String
    let data: [FetchedAnalogDataPoint]
}

struct FetchedDigitalSensorData: Decodable {
    let id: String
    let data: [FetchedDigitalDataPoint]
}

struct FetchedState: Decodable {
    let sensor_status: [FetchedSensorStatus]
    let analog_sensor_data: [String:FetchedAnalogSensorData]
    let digital_sensor_data: [String:FetchedDigitalSensorData]
}


class StateModel {
    static let shared = StateModel()
    var current_state: FetchedState?
    var previous_state: FetchedState?
    
    func fetchState(){
        let stateEndpoint = URL(string: "https://omniscient-app.herokuapp.com/sensors/state")!
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        URLSession.shared.fetchData(for: stateEndpoint,decoder: decoder) { (result: Result<FetchedState, Error>) in
            switch result {
                case .success(let result):
                print("State fetched successfully",result)
                self.current_state = result
                case .failure(let error):
                print("Couldn't fetch state",error)
            }
        }
    }
}

extension Notification.Name {
    static let stateUpdated = Notification.Name("state-updated")
}
