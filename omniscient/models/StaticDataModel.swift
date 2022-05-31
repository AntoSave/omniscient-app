//
//  StaticDataModel.swift
//  omniscient
//
//  Created by Antonio Langella on 31/05/22.
//

import Foundation

struct FetchedCamera: Decodable {
    let name: String
    let room_name: String
    let room_user: String
    let domain: String
    let port: String
    let username: String?
    let password: String?
}
struct FetchedRoom: Decodable {
    let name: String
    let user: String
}
struct FetchedSensor: Decodable{
    let id: String
    let name: String
    let type: String
    let room_name: String
    let room_user: String
}
