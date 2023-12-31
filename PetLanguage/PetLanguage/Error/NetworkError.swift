//
//  NetworkError.swift
//  PetLanguage
//
//  Created by mint on 10/17/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case decoding
    case request
    case server
    case invalidURL
}
