//
//  GPTNetworkService.swift
//  PetLanguage
//
//  Created by minsong kim on 10/14/23.
//

import Foundation

// TODO: - 내용 분리

struct GPTNetworkService: DataTaskManageable {
    private func makeHTTPBody(chats: [PetSetting]) -> Data? {
        var messageList: [[String: String]] = []
        for chat in chats {
            messageList.append(["role": chat.role.useString(), "content": chat.message])
        }
        
        let jsonBody: [String: Any] = [
            "model": GPTSetting.model,
            "messages": messageList
        ]
        
        return try? JSONSerialization.data(withJSONObject: jsonBody)
    }
    
    private func makeURLRequest(chats: [PetSetting]) -> URLRequest {
        let url = URLType.gpt.url
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = HTTPMethod.post.typeName
        urlRequest.httpBody = makeHTTPBody(chats: chats)
        urlRequest.addValue(GPTAuthorization.body, forHTTPHeaderField: GPTAuthorization.title)
        urlRequest.addValue(GPTContentType.body, forHTTPHeaderField: GPTContentType.title)
        
        return urlRequest
    }
    
    func fetchChatGPTData(chats: [PetSetting], completion: @escaping (Result<ChatGPTData, NetworkError>) -> Void) {
        let request = makeURLRequest(chats: chats)
        
        performRequest(request: request, objectType: ChatGPTData.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
