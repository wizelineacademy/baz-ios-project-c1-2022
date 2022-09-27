//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import UIKit

final class MovieAPI {
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    /// Método utilizado para consumir la lista de películas correspondientes acordes al filtro seleccionado.
    ///  - returns: Si el consumo es exitoso, un array con las películas obtenidas; en caso contrario un array vacío
    public func getMovies(url: String, completion: @escaping ([Movie])->()){
        guard let url = URL(string: "\(url)\(apiKey)")
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
