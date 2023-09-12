//
//  APIManager.swift
//  Olympic Athletes
//
//  Created by PADMANABHAN on 11/09/23.
//

import Foundation

//Method Type
enum MethodType : String {
    case get = "GET"
    case post = "POST"
}

//Content Type
enum ContentType : String {
    case applicationJson = "application/json"
}

// Error Messages
enum ApiError : Error {
    case errorMsg(message:String)
    
    var errorDescription:String {
        switch self {
        case let .errorMsg(message): return message
        }
    }
}

class ApiManager {
    
    static let shared = ApiManager()
    
    fileprivate init() {}
    
    let session = URLSession.shared
    
    var baseUrl:URL?
    
    // Feach the API 
    func fetch<T:Codable,R:Codable>(baseUrl:String, methodType:MethodType, contentType:ContentType, param: R? = nil,completion: @escaping(Result<T,ApiError>)->()){
        do {
            
            let url = URL(string: baseUrl)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = methodType.rawValue
           // print(url!)
            urlRequest.addValue("", forHTTPHeaderField: "Authorization")
            if methodType == .post, (param != nil){
                if contentType == .applicationJson {
                    urlRequest.httpBody = try JSONEncoder().encode(param)
                }
            }
            self.session.dataTask(with: urlRequest) { data, response, error in
                if error == nil {
                    // stop loader here
                    //data check
                    guard let data = data else {
                        completion(.failure(.errorMsg(message: error!.localizedDescription)))
                        return
                    }
                    
                    do {
                        // stop loader here
                       // print(urlRequest)
                        let responseData = String(data: data, encoding: String.Encoding.utf8)
                       // print(responseData as Any)
                        let codableData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(codableData))
                    }catch (let error) {
                        // stop loader here
                       // print(url!)
                        completion(.failure(.errorMsg(message: error.localizedDescription)))
                    }
                }else {
                    // stop loader here
                    completion(.failure(.errorMsg(message: error?.localizedDescription ?? "error")))
                }
            }.resume()
            
        }catch (let error) {
            // stop loader here
            completion(.failure(.errorMsg(message: error.localizedDescription)))
        }
    }
}
