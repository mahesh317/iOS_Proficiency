//
//  ServiceManager.swift
//  iOS_Proficiency
//
//  Created by Mahesh Miriyam on 21/07/20.
//  Copyright © 2020 Mahesh Miriyam. All rights reserved.
//

import UIKit
public enum ServiceResult<T> {
    case failure(Error)
    case success(T)
}



fileprivate enum ServiceParamType{
    case facts(String)
    
    var path:String{
        switch self {
        case .facts(_): return "facts.json"
        }
    }
    
    var url:URL?{
        switch self {
        case .facts(let base): return URL(string: base + self.path)
        }
    }
    
}

class ServiceManager {
    
    private let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    
    static let sharedInstance = ServiceManager()
    
    private init() {
    }
    
    func getFacts(callback: @escaping (ServiceResult<Facts>) -> Void){
        guard let url = ServiceParamType.facts(baseUrl).url else {
            return
        }
                
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error{
                callback(.failure(error))
                return
            }
            guard let data = data else{
                return
            }
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let facts = try decoder.decode(Facts.self, from: modifiedDataInUTF8Format)
                callback(.success(facts))
            } catch (let exception){
                print(exception.localizedDescription)
                callback(.failure(exception))
            }
        }
        task.resume()
        
    }
}
