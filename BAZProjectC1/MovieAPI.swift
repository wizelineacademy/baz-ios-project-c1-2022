//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation
import UIKit

class MovieAPI {
    public typealias typeGetMovies            = (_ movies: Movie, _ error: Error?) -> Void
    
    func getMovies(completion: @escaping(typeGetMovies)){
        var movie =  Movie()
        var error: Error?
        let urlString = "\(ConstantsApi.urlAPI)day?api_key=\(ConstantsApi.apiKey)"
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
