//
//  MovieCast.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import Foundation

//MARK: - Protocol Movie Cast
protocol MovieCastProtocol {

    init(movieService: MovieService)
    func loadMoviesCast(completion: @escaping (MovieCast) -> (), _ movieId: Int)
}

final class MovieCastState:MovieCastProtocol {
    
    //MARK: - Properties
    private var actors = MovieCast(cast: [Cast]())
    private let movieService:MovieService
    
    //MARK: - Methods
    init(movieService: MovieService = NetworkManager.shared) {
        self.movieService = movieService
    }
}

//MARK: - Extension Movie Cast
extension MovieCastState {
    //MARK: - Methods
    
    /**
     Function that loads the actors of a specific movie
     - Parameters:
     - completion: closure to get the object movie
     - movieId: id of the movie
     */
    public func loadMoviesCast(completion: @escaping (MovieCast) -> (), _ movieId: Int)  {
        movieService.fetchMovieCast(completion: { [weak self] (actorsCast, erros) in
            guard let self = self else { return }
            if let movieCats = actorsCast {
                self.actors = movieCats
                completion(self.actors)
            } else {
                debugPrint("No cast found")
            }
        }, movieId: movieId)
    }
}
