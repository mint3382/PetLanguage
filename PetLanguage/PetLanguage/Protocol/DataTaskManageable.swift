//
//  DataTaskManageable.swift
//  PetLanguage
//
//  Created by mint on 10/17/23.
//

import Foundation

protocol DataTaskManageable { }

extension DataTaskManageable {
    func performRequest<T: Decodable> (
        request: URLRequest,
        objectType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            if let data {
                do {
                    let result: T = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.invalidURL))
                }
            }
        }.resume()
    }
}
