//
//  ZipCodeModel.swift
//  URLSessionUserDefaultsPractice3B21
//
//  Created by COTEMIG on 18/09/24.
//

import Foundation

struct ZipCodeModel: Codable {
    let zipCode: String
    let publicPlace: String
    let locality: String
    let neighborhood: String
    let uf: String
    let ddd: String
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "cep"
        case publicPlace = "logradouro"
        case locality = "localidade"
        case neighborhood = "bairro"
        case uf
        case ddd
    }
}
