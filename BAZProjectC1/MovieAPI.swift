//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies() -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }

        var movies: [Movie] = []

        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path))
            }
        }

        return movies
    }
    
    func getMoviesUpdate(completion: @escaping ([Movie]) -> ()) {
            guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else {
                return
            }
            
            let session = URLSession.shared
                    session.dataTask(with: url) { (data, response, error) in
                      
                    
                        
                        if let data = data {
                            print(data)
                            do {
                                let json = try JSONSerialization.jsonObject(with: data, options: [])
                               
                                var lstMovies = [Movie]()
                                if let dataInfo = json as? [String : Any], let dataAll = dataInfo["results"] as? [[String: Any]]{
                                    
                                    for item in dataAll {
                                        lstMovies.append(Movie(id: item["id"] as? Int ?? 0, title: item["title"] as? String ?? "", poster_path: item["poster_path"] as? String ?? ""))
                                    }
                                }
                                completion(lstMovies)
                            } catch {
                                print(error)
                                completion([])
                            }
                            
                        }
                    }.resume()
            
        }
    

}
