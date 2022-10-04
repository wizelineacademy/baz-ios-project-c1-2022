//
//  MovieList.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 28/09/22.
//

import Foundation

final class MovieList {
    
    private var actors = MovieCast(cast: [Cast]())
    private var error: NSError?
    private var moviesTrending = Movie(results: [MovieData]())
    private var moviesSearch = SearchMovie(results: [MovieSearchData]())
    
    public func loadMoviesTrending(completion: @escaping (Movie) -> ())  {
        NetworkManager().fetchMovieTrending { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.moviesTrending = page
                completion(self.moviesTrending)
            } else {
                debugPrint("No movies trending found")
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
                debugPrint("No movies \(searchType) found")
            }
        }, filter: searchType) 
    }
    
    public func loadMoviesSimilar(with searchType: String, completion: @escaping (Movie) -> (), _ movieId: Int)  {
        NetworkManager().fetchMovieDetail(completion: { [weak self] (page, error) in
            guard let self = self else { return }
            if let page = page {
                self.moviesTrending = page
                completion(self.moviesTrending)
            } else {
                debugPrint("No movies similar found")
            }
        }, movieId: movieId, filter: searchType)
    }
    
    
    public func loadMoviesCast(with searchType: String, completion: @escaping (MovieCast) -> (), _ movieId: Int)  {
        NetworkManager().fetchMovieCast(completion: { [weak self] (actorsCast, erros) in
            guard let self = self else { return }
            if let movieCats = actorsCast {
                self.actors = movieCats
                completion(self.actors)
            } else {
                debugPrint("No cast found")
            }
        }, movieId: movieId, filter: searchType)
    }
    
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
