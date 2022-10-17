//
//  MovieList.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 28/09/22.
//

import Foundation

//MARK: - Protocol Movie List
protocol MovieListProtocol {
    init(movieService: MovieService)
    func loadMoviesTrending(completion: @escaping (Movie) -> ())
    func loadMovies(with searchType: String, completion: @escaping (Movie) -> ())
    func loadMoviesDetail(with searchType: String, completion: @escaping (Movie) -> (), _ movieId: Int)
}

final class MovieList: MovieListProtocol {
    
    //MARK: - Properties
    private var movies = Movie(results: [MovieData]())
    private let movieService: MovieService
    
    //MARK: - Methods
    init(movieService: MovieService = NetworkManager.shared) {
        self.movieService = movieService
    }
}

//MARK: - Extension Movie List
extension MovieList {
    //MARK: - Methods
    
    /**
     Function that loads the movies of the trending category
     - Parameters:
     - completion: closure to get  the object movie
     */
     func loadMoviesTrending(completion: @escaping (Movie) -> ())  {
        movieService.fetchMovieTrending { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.movies = page
                completion(self.movies)
            } else {
                debugPrint("No movies trending found")
            }
        }
    }
    
    /**
     Function that loads the movies depending on the filter that is desired
     - Parameters:
     - searchType: filter type such as upcoming, popular, etc.
     - completion: closure to get the object movie
     */
    func loadMovies(with searchType: String, completion: @escaping (Movie) -> ())  {
        movieService.fetchMovieFilter(completion: { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.movies = page
                completion(self.movies)
            } else {
                debugPrint("No movies \(searchType) found")
            }
        }, filter: searchType)
    }
    
    /**
     Function that loads the detail movies as they are similar or recommended
     - Parameters:
     - searchType: filter type similar  or recommended
     - completion: closure to get the object movie
     */
    func loadMoviesDetail(with searchType: String, completion: @escaping (Movie) -> (), _ movieId: Int)  {
        movieService.fetchMovieDetail(completion: { [weak self] (page, error) in
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
