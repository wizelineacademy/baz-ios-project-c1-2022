//
//  TrendingMovieViewModel.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 19/09/22.
//

import Foundation

class TrendingMovieViewModel {
    
    //Mecanismo para enlace del modelo con la vista
    var refreshData = { () -> () in }
    
    var movieDataArray: [Result] = [] {
        didSet  {
            refreshData()
        }
    }
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let urlBase = "https://api.themoviedb.org/3"
    
    func getMovies () {
        let endPoint = "/trending/movie/day?api_key=\(apiKey)"
        
        guard let url = URL(string: urlBase + endPoint) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                debugPrint (error?.localizedDescription ?? "Error")
                return
            }
            
            guard let json = data else {return}
            
            //Serializar datos
            do{
                let result = try JSONDecoder().decode(Movie.self, from: json)
                self.movieDataArray = result.results
            } catch let error {
                debugPrint("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
