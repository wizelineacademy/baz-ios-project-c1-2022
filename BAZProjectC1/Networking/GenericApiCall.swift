//
//  GenericApiCall.swift
//  BAZProjectC1
//
//  Created by 1054812 on 26/09/22.
//

import UIKit

class GenericApiCall {
    /// Enum utilizado para validar algunos de los posibles errores al consumir una API
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    static let searchMovieURL = "https://api.themoviedb.org/3/search/multi?api_key=\(apiKey)&query="
    
    /// Método genérico utilizado para el consumo de APIS.
    ///  - Parameters:
    ///     - url: Contiene la petición que se requiere ejecutar
    ///     - expecting: Corresponde al modelo de datos con el que se va a trabajar
    ///     - completion: El resultado de la petición
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
