//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

struct MovieAPI {
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    func moviesList(completion: @escaping ([MovieData]) -> (), searchType: String) {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(searchType)/movie/day?api_key=\(apiKey)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data!)
                completion(result.results)
                print(result)
            } catch {
                
            }
        }.resume()
    }
}
