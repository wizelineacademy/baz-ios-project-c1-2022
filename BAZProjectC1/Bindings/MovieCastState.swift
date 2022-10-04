//
//  MovieCast.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import Foundation

final class MovieCastState {
    
    private var actors = MovieCast(cast: [Cast]())
    
    public func loadMoviesCast(completion: @escaping (MovieCast) -> (), _ movieId: Int)  {
        NetworkManager().fetchMovieCast(completion: { [weak self] (actorsCast, erros) in
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
