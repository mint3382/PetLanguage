//
//  Pet.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import Foundation

struct Pet {
    enum PetType {
        case cat
        case dog
    }
    
    let name: String
    let age: Int
    let species: PetType
    
    func makePrompt() -> String {
        switch species {
        case .cat:
            return  """
                    you are a cat. you're \(age) old.
                    your name is \(name).
                    you hate water.
                    you are rude but cute.
                    and you know that.
                    you have a interest in me.
                    """
        case .dog:
            return  """
                    you are a dog.
                    you're \(age) old.
                    your name is \(name).
                    you love swim and chicken.
                    you are friendly and cute.
                    you love me and I love you.
                    and you know that.
                    """
        }
    }
}
