//
//  MovieSearch.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import Foundation

//MARK: - Protocol Movie Search
protocol MovieSearchProtocol {
    
    init(movieService: MovieService)
    func loadMoviesSearch(with keyword: String, completion: @escaping (Movie) -> ())
}

final class MovieSearch:MovieSearchProtocol {
    
    //MARK: - Properties
    private var moviesSearch = Movie(results: [MovieData]())
    private let movieService:MovieService
    
    //MARK: - Methods
    init(movieService: MovieService = NetworkManager.shared) {
        self.movieService = movieService
    }
}

//MARK: - Extension Movie Search
extension MovieSearch {
    
    //MARK: - Methods
    public func loadMoviesSearch(with keyword: String, completion: @escaping (Movie) -> ())  {
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

