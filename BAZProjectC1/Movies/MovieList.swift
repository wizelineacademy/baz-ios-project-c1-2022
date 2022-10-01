//
//  MovieList.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 28/09/22.
//

import Foundation

final class MovieList {
    
    var movies:[Movie]?
    var error: NSError?
    var moviesTrending = Movie(results: [MovieData]())
    public func loadMoviesTrending(completion: @escaping (Movie) -> ())  {
        NetworkManager().fetchMovieTrending { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.moviesTrending = page
                completion(self.moviesTrending)
            } else {
                print("No movies found")
            }
        }
    }
    
    public func loadMovies(with searchType: String, completion: @escaping (Movie) -> ())  {
        NetworkManager().fetchMovieFilter(completion: { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.moviesTrending = page
                completion(self.moviesTrending)
            } else {
                print("No movies found")
            }
        }, filter: searchType) 
    }
}
