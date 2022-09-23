//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

internal final class MovieAPI: APIURLHandler {
    override init(url: String) {
        super.init(url: url)
    }
    
    func getMovies() -> [Movie] {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieResults.self, from: data) else { return [] }
        return result.results
    }
    
    func getMovieDetail() -> MovieDetail? {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieDetailResults.self, from: data) else { return nil }
        return result.results.first
    }

}
