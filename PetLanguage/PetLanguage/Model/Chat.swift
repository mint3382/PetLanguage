//
//  Chat.swift
//  PetLanguage
//
//  Created by mint on 10/13/23.
//

struct Chat {
    enum Sender {
        case user
        case pet
    }
    
    let sender: Sender
    let message: String?
    
    init(sender: Sender, message: String?) {
        self.sender = sender
        self.message = message
    }
}
