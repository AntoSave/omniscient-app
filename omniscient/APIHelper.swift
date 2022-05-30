//
//  APIController.swift
//  omniscient
//
//  Created by Antonio Langella on 30/05/22.
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

extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let object = try JSONDecoder().decode(T.self, from: data)
          completion(.success(object))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
