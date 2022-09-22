//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import UIKit

final class MovieAPI {
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
  public func getMovies(completion: @escaping ([Movie])->()){
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")
        else { return  }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "error")
                return
            }
            do {
                guard let data = data else { return }
                
                let result = try JSONDecoder().decode(ResultsApi.self, from: data)
                completion(result.results)
                
            }catch let error {
                 completion([])
                print(error)
            }
        }.resume()
    }
}
