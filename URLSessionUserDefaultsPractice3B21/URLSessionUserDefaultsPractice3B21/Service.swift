//
//  Service.swift
//  URLSessionUserDefaultsPractice3B21
//
//  Created by COTEMIG on 18/09/24.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case decodeFailure(Error)
    case networkError(Error?)
}

class Service {
    private let baseURL = "https://viacep.com.br/ws/"
    
    func searchZipCode(_ zipCode: String, callback: @escaping (Result<ZipCodeModel, ServiceError>) -> Void ) {
        let path = "\(zipCode)/json"
        
        guard let url = URL(string: baseURL + path) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                callback(.failure(.networkError(error)))
                return
            }
            
            do {
                let address = try JSONDecoder().decode(ZipCodeModel.self, from: data)
                callback(.success(address))
                
            } catch{
                callback(.failure(.decodeFailure(error)))
            }
        }
        task.resume()
    }
}
