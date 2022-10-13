//
//  MovieCast.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import Foundation


protocol MovieCastProtocol {

    init(movieService: MovieService)
    func loadMoviesCast(completion: @escaping (MovieCast) -> (), _ movieId: Int)
}

final class MovieCastState:MovieCastProtocol {
    
    private var actors = MovieCast(cast: [Cast]())
    private let movieService:MovieService
    
    init(movieService: MovieService = NetworkManager.shared) {
        self.movieService = movieService
    }
}

extension MovieCastState {
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
