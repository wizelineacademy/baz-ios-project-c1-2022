//
//  TrendingMovieViewModel.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 19/09/22.
//

import Foundation

class TrendingMovieViewModel {
    
    //MARK: -Mecanismo para enlace del modelo con la vista
    var refreshData = { () -> () in }
    
    //MARK: - Contenedor de datos
    var movieDataArray: [MovieData] = [] {
        didSet  {
            refreshData()
        }
    }
    
    func getMovies(_ endPoint: EndPoint) {
        let url = endPoint.requestFrom
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                debugPrint (error?.localizedDescription ?? "Error")
                return
            }
            do{
                guard let data = data else {
                    return
                }
                let result = try JSONDecoder().decode(MoviesResponse.self, from: data)
                self.movieDataArray = result.results
            } catch {
                debugPrint("The following error occurred: \(error.localizedDescription)")
            }
        }.resume()
    }
}

