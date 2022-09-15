//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

public final class MovieAPI: APIURLHandler {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies() -> [Movie] {
        
        let results = self.getURLContent(url: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")
        
        var movies: [Movie] = []

        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path))
            }
        }

        return movies
    }

}
