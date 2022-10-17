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
