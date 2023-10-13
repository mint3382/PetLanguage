//
//  Bundle+.swift
//  PetLanguage
//
//  Created by minsong kim on 10/13/23.
//

import Foundation

extension Bundle {
    var chatGPTAPIKey: String {
        guard let file = self.path(forResource: "ChatGPTInfo", ofType: "plist") else {
            return ""
        }
        
        guard let resource = NSDictionary(contentsOfFile: file) else {
            return ""
        }
        
        guard let key = resource["API_KEY"] as? String else {
            fatalError("chatGPTAPIKey error")
        }
        
        return key
    }
}
