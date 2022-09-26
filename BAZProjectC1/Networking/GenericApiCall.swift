//
//  GenericApiCall.swift
//  BAZProjectC1
//
//  Created by 1054812 on 26/09/22.
//

import UIKit

class GenericApiCall {
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    
    public static func request<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
