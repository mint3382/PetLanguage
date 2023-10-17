//
//  URLType.swift
//  PetLanguage
//
//  Created by minsong kim on 10/17/23.
//

import Foundation

enum Scheme {
    static let http = "https"
}

enum HostName {
    static let openAI = "api.openai.com"
}

enum Path {
    static let gpt = "/v1/chat/completions"
}

enum URLType {
    case gpt
    
    var url: URL {
        switch self {
        case .gpt:
            return configureURL(host: HostName.openAI, path: Path.gpt)
        }
    }
    
    private func configureURL(host: String, path: String) -> URL {
        var component = URLComponents()
        
        component.scheme = Scheme.http
        component.host = host
        component.path = path
        
        guard let url = component.url else {
            fatalError(NetworkError.invalidURL.localizedDescription)
        }
        
        return url
    }
}
