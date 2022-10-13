//
//  MovieSearch.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import Foundation

protocol MovieSearchProtocol {
    
    init(movieService: MovieService)
    func loadMoviesSearch(with keyword: String, completion: @escaping (SearchMovie) -> ())
}

final class MovieSearch:MovieSearchProtocol {
    
    private var moviesSearch = SearchMovie(results: [MovieSearchData]())
    private let movieService:MovieService
    
    init(movieService: MovieService = NetworkManager.shared) {
        self.movieService = movieService
    }
}

extension MovieSearch {
    
    public func loadMoviesSearch(with keyword: String, completion: @escaping (SearchMovie) -> ())  {
        movieService.fetchMovieSearch(completion: { [weak self] (movies,error) in
            guard let self = self else { return }
            if let page = movies {
                self.moviesSearch = page
                completion(self.moviesSearch)
            } else {
                debugPrint("No movies search found")
            }
        }, keyword: keyword)
    }
}

