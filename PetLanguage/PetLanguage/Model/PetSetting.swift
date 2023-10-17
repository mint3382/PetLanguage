//
//  PetSetting.swift
//  PetLanguage
//
//  Created by mint on 10/15/23.
//

struct PetSetting {
    let role: Role
    let message: String
    
    init(role: Role, message: String) {
        self.role = role
        self.message = message
    }
}
