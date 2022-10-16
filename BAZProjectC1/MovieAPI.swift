//
//  MovieAPI.swift
//  BAZProjectC1
//
//Created by rnunezi on 13/10/22.
//

import Foundation
import UIKit

//MARK: - MovieAPI Management

class MovieAPI {
    public typealias typeGetMovies            = (_ movies: Movie, _ error: Error?) -> Void
    
    //   Method: Returns the data of querying the API of the movies
    public func getMovies(completion: @escaping(typeGetMovies)){
        var movie =  Movie(results: [])
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
