//
//  Role.swift
//  PetLanguage
//
//  Created by minsong kim on 10/15/23.
//

import Foundation

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
