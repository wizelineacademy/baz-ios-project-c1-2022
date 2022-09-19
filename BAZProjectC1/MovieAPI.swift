//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies(handler: @escaping ([Movie]) -> ()) {
        let algo = "https://image.tmdb.org/t/p/"
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDay.self, from: data)
                handler(result.results)
            }catch {
                print("catch: \(error.localizedDescription)")
            }
        }.resume()
    }

}

struct MovieDay: Codable {
    let results: [Movie]
}
