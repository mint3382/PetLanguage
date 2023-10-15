//
//  PetSetting.swift
//  PetLanguage
//
//  Created by minsong kim on 10/15/23.
//

import Foundation

struct PetSetting {
    let role: Role
    let message: String
    
    init(role: Role, message: String) {
        self.role = role
        self.message = message
    }
}
