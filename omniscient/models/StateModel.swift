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
    let sensor_status: [String:FetchedSensorStatus]
    let analog_sensor_data: [String:FetchedAnalogSensorData]
    let digital_sensor_data: [String:FetchedDigitalSensorData]
}

struct FetchedAlarmState: Decodable {
    let isAlarmed: Bool
}

class StateModel {
    static let shared = StateModel()
    var current_state: FetchedState?
    var previous_state: FetchedState?
    var isAlarmed: Bool = false
    
    func fetchState(){
        let stateEndpoint = URL(string: "https://omniscient-app.herokuapp.com/sensors/state")!
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        URLSession.shared.fetchData(for: stateEndpoint,decoder: decoder) { (result: Result<FetchedState, Error>) in
            switch result {
            case .success(let result):
                //print("State fetched successfully",result)
                self.current_state = result
                NotificationCenter.default.post(name: NSNotification.Name.stateChanged, object: nil)
            case .failure(let error):
                print("Couldn't fetch state!")
                //print("Couldn't fetch state",error)
            }
        }
        //print(current_state)
        //print("State change notified!")
    }
    func fetchAlarmState(){
        let alarmEndpoint = URL(string: "https://omniscient-app.herokuapp.com/status/alarmed")!
        URLSession.shared.fetchData(for: alarmEndpoint) { (result: Result<FetchedAlarmState, Error>) in
            switch result {
                case .success(let result):
                    self.isAlarmed=result.isAlarmed
                    print("ALARMED:",self.isAlarmed)
                    NotificationCenter.default.post(name: NSNotification.Name.alarmStateChanged, object: nil)
                case .failure(let error):
                    print("Couldn't fetch alarm state!")
            }
        }
    }
}

extension Notification.Name {
    static let stateChanged = Notification.Name("state-changed")
    static let alarmStateChanged = Notification.Name("alarm-state-changed")
}
