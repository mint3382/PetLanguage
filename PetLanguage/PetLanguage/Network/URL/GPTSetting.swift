//
//  GPTSetting.swift
//  PetLanguage
//
//  Created by minsong kim on 10/17/23.
//

import Foundation

enum GPTSetting {
    static let model = "gpt-3.5-turbo"
}

enum GPTAuthorization {
    static let title = "Authorization"
    static let body = "Bearer \(Bundle.main.chatGPTAPIKey)"
}

enum GPTContentType {
    static let title = "Content-Type"
    static let body = "application/json"
}
