//  MovieAPI.swift
//  BAZProjectC1

import Foundation

final class MovieAPI {
    //MARK: - B L O C K
    public typealias blkGetMovies = (Movie?, Error?) -> Void
    
    //MARK: - E N U M
    private enum apiKeys: String {
        case apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    
    //MARK: - A P I · K E Y
    private let strHost: String = "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKeys.apiKey.rawValue)"
    private let strImageHost: String = "https://image.tmdb.org/t/p/w500"

    
    //MARK: - F U N C T I O N S
    func getMovies(completion: @escaping blkGetMovies) {
        guard let url = URL(string: strHost)  else { return }
        URLSession.shared.dataTask(with: url) { ( data, respoonse, error) in
            guard let datos = data else { return }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(Movie.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil,error)
            }
        }.resume()
    }
}
