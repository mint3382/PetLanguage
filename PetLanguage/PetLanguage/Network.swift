//
//  Network.swift
//  PetLanguage
//
//  Created by minsong kim on 10/14/23.
//

import Foundation

struct Network {
    func makeURLRequest(chats: [PetSetting]) -> URLRequest {
        let bearerToken = Bundle.main.chatGPTAPIKey
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else { fatalError("Missing URL")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        var chatting: [[String: String]] = []
        for chat in chats {
            chatting.append(["role": chat.role.useString(), "content": chat.message])
        }
        let jsonBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": chatting
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
        
        urlRequest.httpBody = jsonData
        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
    
    func performRequest (
        request: URLRequest,
        completion: @escaping (Result<ChatGPTData, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.request))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(NetworkError.server))
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                }
                return
            }
            
            if let data {
                do {
                    let result = try JSONDecoder().decode(ChatGPTData.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.decoding))
                }
            }
        }.resume()
    }
//    
//    static func fetchChat(chats: [PetSetting]) async throws -> ChatGPTData {
//        var urlRequest = makeURLRequest()
//        var chatting: [[String: String]] = []
//        for chat in chats {
//            chatting.append(["role": chat.role.useString(), "content": chat.message])
//        }
//        let jsonBody: [String: Any] = [
//            "model": "gpt-3.5-turbo",
//            "messages": chatting
//        ]
//        
//        let jsonData = try? JSONSerialization.data(withJSONObject: jsonBody)
//        
//        urlRequest.httpBody = jsonData
//        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw NetworkError.server
//        }
//        
//        let chatResponse = try JSONDecoder().decode(ChatGPTData.self, from: data)
//        
//        return chatResponse
//    }
}

enum NetworkError: LocalizedError {
    case decoding
    case request
    case server
}
