//
//  APIRequest.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import Foundation

enum APICallType: String {
    
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}


class GenericAPIService : NSObject {
    
    func genericApiCall<T: Decodable>(urlStr: String , type: APICallType, completionHandler: @escaping (T) -> () ) {
        let url = urlStr
        
        var urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        urlRequest.httpMethod = type.rawValue
        
        _ = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let data {
                
                if let placesData = try? JSONDecoder().decode(T.self, from: data) {
                    completionHandler(placesData)
                } else {
                    print(error?.localizedDescription)
                }
                
            }
        }.resume()
    }
    
}
