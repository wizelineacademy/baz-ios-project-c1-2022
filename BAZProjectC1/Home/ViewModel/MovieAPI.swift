//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import UIKit

final class MovieAPI {
    
    /// Método utilizado para consumir la lista de películas correspondientes acordes al filtro seleccionado.
    ///  - Parameters:
    ///     - url: Contiene la petición que se requiere ejecutar
    ///     - completion: El resultado de la petición
    public func getMovies(url: String, completion: @escaping ([Movie])->()){
        guard let url = URL(string: "\(url)\(GenericApiCall.apiKey)")
        else { return  }
        GenericApiCall.request(url: url, expecting: ResultsApi.self) { result in
            switch result {
            case .success(let result):
                completion(result.results)
            case .failure(let error):
                completion([])
                print(error)
            }
        }
    }
    
    /// Método utilizado para realizar la búsqueda de pelicular por nombre o actor
    ///  - Parameters:
    ///     - url: Contiene la petición que se requiere ejecutar
    ///     - textToSearch: Clave por la que se realizará la búsqueda
    ///     - completion: El resultado de la petición
    public func searchMovie(url: String, textToSearch: String, completion: @escaping ([Movie])->()) {
        let textToSearch = textToSearch.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "\(url)\(textToSearch)")
        else { return  }
        
        GenericApiCall.request(url: url, expecting: ResultsApi.self) { result in
            switch result {
            case .success(let result):
                completion(result.results)
            case .failure(let error):
                completion([])
                print(error)
            }
        }
    }
}
