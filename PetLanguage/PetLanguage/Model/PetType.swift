//
//  PetType.swift
//  PetLanguage
//
//  Created by mint on 10/16/23.
//

enum PetType {
    case cat
    case dog
    
    func randomImage() -> String {
        switch self {
        case .cat:
            return "cat\(Int.random(in: 1...16))"
        case .dog:
            return "dog\(Int.random(in: 1...6))"
        }
    }
}
