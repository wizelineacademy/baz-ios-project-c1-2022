//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    func getMovies(completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(Response.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
}
