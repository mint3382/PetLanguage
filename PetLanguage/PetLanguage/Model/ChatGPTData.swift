//
//  ChatGPTData.swift
//  PetLanguage
//
//  Created by mint on 10/13/23.
//

struct ChatGPTData: Decodable {
    let choices: [Choice]
    let created: Int
    let id: String
    let model: String
    let object: String
    let usage: Usage
}

struct Choice: Decodable {
    let finishReason: String
    let index: Int
    let message: Message

    enum CodingKeys: String, CodingKey {
        case finishReason = "finish_reason"
        case index, message
    }
}

struct Message: Decodable {
    let content:String
    let role: String
}

struct Usage: Decodable {
    let completionTokens: Int
    let promptTokens: Int
    let totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case completionTokens = "completion_tokens"
        case promptTokens = "prompt_tokens"
        case totalTokens = "total_tokens"
    }
}
