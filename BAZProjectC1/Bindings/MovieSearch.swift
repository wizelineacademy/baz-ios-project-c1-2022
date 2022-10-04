//
//  MovieSearch.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import Foundation

final class MovieSearch {
    
    private var moviesSearch = SearchMovie(results: [MovieSearchData]())
    public func loadMoviesSearch(with keyword: String, completion: @escaping (SearchMovie) -> ())  {
        NetworkManager().fetchMovieSearch(completion: { [weak self] (movies,error) in
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

