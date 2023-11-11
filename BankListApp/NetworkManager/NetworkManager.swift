//
//  NetworkManager.swift
//  BankListApp
//
//  Created by Geisel Roque on 11/11/23.
//

import Foundation
import SystemConfiguration

enum HttpMethod:String{
  case get = "get"
  case post = "post"
}

class NetworkManager {
  
  static let shared = NetworkManager()
  typealias Metodo = HttpMethod
  
  func make<A:Encodable, T:Codable>(url:String, metodo:Metodo, parametros:A?, headers: [String:String]? = nil, completion: @escaping (T?,CodeResponse?) -> ()) {
    guard Reachability().isConnectedToNetwork() else {
      completion(nil,CodeResponse.not_connection)
      return
    }
    
    requestResource(serviceURL: url, httpMethod: metodo, parameters: parametros, headers: headers, completion: completion)
  }

  func makeGetRequest<T:Codable>(url:String, headers: [String:String]? = nil, completion: @escaping (T?,CodeResponse?) -> ()) {
    guard Reachability().isConnectedToNetwork() else {
      completion(nil,CodeResponse.not_connection)
      return
    }
    
    requestResource(serviceURL: url, httpMethod: .get, parameters: DummyCodable(), headers: headers, completion: completion)
  }
  
  private func requestResource<A:Encodable,T:Codable>(serviceURL:String,httpMethod:HttpMethod,parameters:A?, headers: [String:String]? = nil, completion: @escaping (T?,CodeResponse?) -> ()) {
    guard let urlForRequest = URL(string: serviceURL) else {
      print("WRONG URL \(serviceURL)")
      completion(nil,CodeResponse.bad_url)
      return
    }
    var urlRequest:URLRequest = URLRequest(url: urlForRequest)
    urlRequest.httpMethod = httpMethod.rawValue
    urlRequest.timeoutInterval = 35
    
    print(urlRequest)
    
    for header in headers ?? [:]{
      urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
    }
    
    if httpMethod != .get {
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
      if let contenido = parameters {
        urlRequest.httpBody = try? JSONEncoder().encode(contenido)
      }
      if (parameters != nil) {
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
      }
    }

    let sessionTask = URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
      
      if (data != nil){
        guard let response = response, let statusCode = (response as? HTTPURLResponse)?.statusCode else {
          completion(nil,CodeResponse.unknow)
          return
        }
        
        let code = CodeResponse(rawValue: statusCode) ?? CodeResponse.unknow
        if code == .unknow { print("Code not implemented \(statusCode)") }
        
        if (code == .ok){
          do {
            let obj = try JSONDecoder().decode(T.self, from: data!)
            completion(obj,code)
          }
          catch let jsonError{
            print("Falied to decode Json: ",jsonError)
            completion(nil,.bad_decodable)
          }
        } else {
          print("Some code \(statusCode)")
          let obj = try? JSONDecoder().decode(T.self, from: data!)
          completion(obj,code)
        }
      }
      
      if (error != nil) {
        completion (nil,.unknow)
      }
    }
    sessionTask.resume()
  }
}

class DummyCodable: Encodable,Decodable{}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
  func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
    return try encoder.encode(self)
  }
}

