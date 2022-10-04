//
//  MovieList.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 28/09/22.
//

import Foundation

final class MovieList {
    
    private var movies = Movie(results: [MovieData]())
    
    public func loadMoviesTrending(completion: @escaping (Movie) -> ())  {
        NetworkManager().fetchMovieTrending { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.movies = page
                completion(self.movies)
            } else {
                debugPrint("No movies trending found")
            }
        }
    }
    
    public func loadMovies(with searchType: String, completion: @escaping (Movie) -> ())  {
        NetworkManager().fetchMovieFilter(completion: { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.movies = page
                completion(self.movies)
            } else {
                debugPrint("No movies \(searchType) found")
            }
        }, filter: searchType) 
    }
    
    public func loadMoviesDetail(with searchType: String, completion: @escaping (Movie) -> (), _ movieId: Int)  {
        NetworkManager().fetchMovieDetail(completion: { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.movies = page
                completion(self.movies)
            } else {
                debugPrint("No movies \(searchType) found")
            }
        }, movieId: movieId, filter: searchType)
    }
}

