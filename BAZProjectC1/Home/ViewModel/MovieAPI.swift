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
    
    /// Método utilizado para realizar la búsqueda de pelicular por nombre o actor
    ///  - Parameters:
    ///     - movie: id de la película a consultar
    ///     - url: Contiene la petición que se requiere ejecutar
    ///     - completion: El resultado de la petición
    public func getDetail(for movie: Int, url: String, completion: @escaping (MovieDetail?)->()) {
        let url = url.replacingOccurrences(of: "idMovie", with: "\(movie)")
        guard let url = URL(string: "\(url)")
        else { return  }
        
        GenericApiCall.request(url: url, expecting: MovieDetail.self) { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    
}
