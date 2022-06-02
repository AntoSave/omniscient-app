//
//  APIController.swift
//  omniscient
//
//  Created by Antonio Langella on 30/05/22.
//

import Foundation

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
    
    func fetchData<T: Decodable>(for url: URL, decoder: JSONDecoder, completion: @escaping (Result<T, Error>) -> Void) {
      self.dataTask(with: url) { (data, response, error) in
        if let error = error {
          completion(.failure(error))
        }

        if let data = data {
          do {
            let object = try decoder.decode(T.self, from: data)
            completion(.success(object))
          } catch let decoderError {
            completion(.failure(decoderError))
          }
        }
      }.resume()
    }
}

class APIHelper{
    static func createCamera(cameraName: String,roomName: String,domain: String,port: String,username: String,password: String,completion: @escaping (Result<String, Error>) -> Void){
        let url = URL(string: "https://omniscient-app.herokuapp.com/cameras")!
        var json: [String: Any] = [
            "name": cameraName,
            "room_name": roomName,
            "domain": domain,
            "port": port
        ]
        if username != "" {
            json["username"]=username
        }
        if password != "" {
            json["password"]=password
        }
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("error")
                completion(.failure(error))
                return
            }
            let res = response as! HTTPURLResponse
            if(res.statusCode != 200){
                print("error")
                let body = String(decoding: data!,as: UTF8.self)
                completion(.failure(NSError(domain: body, code: res.statusCode)))
                return
            }
            print("success")
            completion(.success("SUCCESS"))
        }.resume()
    }
    static func deleteCamera(cameraName: String, roomName: String,completion: @escaping (Result<String, Error>) -> Void){
        let url = URL(string: "https://omniscient-app.herokuapp.com/cameras")!
        var json: [String: Any] = [
            "name": cameraName,
            "room_name": roomName
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("error")
                completion(.failure(error))
                return
            }
            let res = response as! HTTPURLResponse
            if(res.statusCode != 200){
                print("error")
                let body = String(decoding: data!,as: UTF8.self)
                completion(.failure(NSError(domain: body, code: res.statusCode)))
                return
            }
            print("success")
            completion(.success("SUCCESS"))
        }.resume()
    }
    
    static func createRoom(roomName: String,completion: @escaping (Result<String, Error>) -> Void){
        let url = URL(string: "https://omniscient-app.herokuapp.com/rooms")!
        var json: [String: Any] = [
            "name": roomName
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("error")
                completion(.failure(error))
                return
            }
            let res = response as! HTTPURLResponse
            if(res.statusCode != 200){
                print("error")
                let body = String(decoding: data!,as: UTF8.self)
                completion(.failure(NSError(domain: body, code: res.statusCode)))
                return
            }
            print("success")
            completion(.success("SUCCESS"))
        }.resume()
    }
    
    static func deleteRoom(roomName: String,completion: @escaping (Result<String, Error>) -> Void){
        let url = URL(string: "https://omniscient-app.herokuapp.com/rooms")!
        var json: [String: Any] = [
            "name": roomName
        ]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                print("error")
                completion(.failure(error))
                return
            }
            let res = response as! HTTPURLResponse
            if(res.statusCode != 200){
                print("error")
                let body = String(decoding: data!,as: UTF8.self)
                completion(.failure(NSError(domain: body, code: res.statusCode)))
                return
            }
            print("success")
            completion(.success("SUCCESS"))
        }.resume()
    }
}
