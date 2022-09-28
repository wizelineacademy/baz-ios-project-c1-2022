//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation
import UIKit

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let urlAPI: String = "https://api.themoviedb.org/3/trending/movie/"
    public typealias typeGetMovies            = (_ movies: Movie, _ error: Error?) -> Void
    
    func getMovies(completion: @escaping(typeGetMovies)){
        var movie =  Movie()
        var error: Error?
        let urlString = "\(urlAPI)day?api_key=\(apiKey)"
        let url = URL (string: urlString)!
    
        URLSession.shared.dataTask(with: url){ (data, res, err) in
            
            if let data = data {
                if let json = try? JSONDecoder().decode(Movie.self, from: data){
                    movie = json
                }
            }
            error = err
            completion(movie,error)
            
        }.resume()
        
    }
}
