//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

final class MovieAPI {
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let urlBase = "https://api.themoviedb.org/3"
    
    func getMovies(completion: @escaping ([Movie])->()){
        let endPoint = "/trending/movie/day?api_key=\(apiKey)"
        
        guard let url = URL(string: urlBase + endPoint) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                debugPrint (error?.localizedDescription ?? "Error")
                return
            }
            
            do{
                guard let data = data else {
                    return
                }
                let result = try JSONDecoder().decode(Results.self, from: data)
                completion(result.results)
            } catch {
                debugPrint("The following error occurred: \(error.localizedDescription)")
            }
        }.resume()
    }
}
