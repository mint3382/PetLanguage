//
//  Role.swift
//  PetLanguage
//
//  Created by mint on 10/15/23.
//

enum Role {
    case system
    case user
    case assistant
    
    func useString() -> String {
        switch self {
        case .system:
            return "system"
        case .assistant:
            return "assistant"
        case .user:
            return "user"
        }
    }
}
