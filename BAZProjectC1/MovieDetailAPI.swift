//
//  MovieDetailAPI.swift
//  BAZProjectC1
//
//  Created by 1030361 on 03/10/22.
//

import Foundation

//https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es

internal final class MovieDetailAPI: APIURLHandler {
    override init(url: String) {
        super.init(url: url)
    }
    
    func getMovieDetails() -> MovieDetail? {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieDetail.self, from: data) else { return nil }
        print("result \(result)")
        return result
    }
    
    func getMovieReviews() -> [MovieReviews]? {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieReviewsResults.self, from: data) else { return nil }
        return result.results
    }
    
    func getMovieSimilars() -> [MovieSimilars]? {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieSimilarsResults.self, from: data) else { return nil }
        return result.results
    }
    
    func getMovieRecommendations() -> [MovieSimilars]? {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieSimilarsResults.self, from: data) else { return nil }
        return result.results
    }
    
    func getMovieCast() -> [Cast]? {
        guard let data = self.getDataFromURL(),
              let result = try? JSONDecoder().decode(MovieCast.self, from: data) else { return nil }
        return result.cast
    }
}
