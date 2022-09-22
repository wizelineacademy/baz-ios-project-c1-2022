//  MovieAPI.swift
//  BAZProjectC1

import Foundation

final class MovieAPI {
    //MARK: - B L O C K
    public typealias blkGetMovies = (MovieAPIResponse?, Error?) -> Void
    public typealias blkGetNowPlaying = (NowPlayingAPIResponse?, Error?) -> Void
    public typealias blkGetPopular = (PopularAPIResponse?, Error?) -> Void
    
    //MARK: - E N U M
   /*
    private enum apiKeys: String {
        case apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    } */
    
    private enum paths: String {
        case trending = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case popular = "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }

    //MARK: - F U N C T I O N S
    func getMoviesTrending(completion: @escaping blkGetMovies) {
        guard let url = URL(string: "\(paths.trending.rawValue)")  else { return }
        URLSession.shared.dataTask(with: url) { ( data, respoonse, error) in
            guard let datos = data else { return }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(MovieAPIResponse.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil,error)
            }
        }.resume()
    }
    
    
    func getNowPlaying(completion: @escaping blkGetNowPlaying) {
        guard let url = URL(string: "\(paths.nowPlaying.rawValue)")  else { return }
        URLSession.shared.dataTask(with: url) { ( data, respoonse, error) in
            guard let datos = data else { return }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(NowPlayingAPIResponse.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil,error)
            }
        }.resume()
    }
    
    func getPopular(completion: @escaping blkGetPopular) {
        guard let url = URL(string: "\(paths.popular.rawValue)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let datos = data else { return }
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(PopularAPIResponse.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
