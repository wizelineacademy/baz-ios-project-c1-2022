//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation
import UIKit

class MovieAPI {

    static let shared: MovieAPI = MovieAPI()
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies(genre: String, completionHandler: @escaping ((Movies) -> Void)) {
        var url: String!
        if genre == "trending" {
            url = "https://api.themoviedb.org/3/\(genre)/movie/day?api_key=\(apiKey)"
        } else {
            url = "https://api.themoviedb.org/3/movie/\(genre)?api_key=\(apiKey)"
        }
        
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else { return }

        var movies: Movies = []

        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let posterPath = result.object(forKey: "poster_path") as? String {
                movies.append(Movie(id: id, title: title, posterPath: posterPath, posterImage: UIImage()))
            }
        }
        completionHandler(movies)
    }

    private func getPosterImage(_ psterPath: String) -> UIImage? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(psterPath)?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let poster = UIImage(data: data)
        else { return nil }
        return poster
    }
}
