//  MovieAPI.swift
//  BAZProjectC1

import Foundation

final class MovieAPI {
    //MARK: - B L O C K
    public typealias blkGetMovies = (MovieAPIResponse?, Error?) -> Void
    public typealias blkGetNowPlaying = (NowPlayingAPIResponse?, Error?) -> Void
    public typealias blkGetPopular = (PopularAPIResponse?, Error?) -> Void
    public typealias blkGetTopRated = (TopRatedAPIResponse?, Error?) -> Void
    public typealias blkGetUpcoming = (UpcomingAPIResponse?, Error?) -> Void
    
    //MARK: - E N U M
    private enum paths: String {
        case trending = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case popular = "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }

    //MARK: - G E T · T R E N D I N G
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
    
    //MARK: - G E T · N O W · P L A Y I N G
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
    
    //MARK: - G E T · P O P U L A R
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
    
    //MARK: - G E T · T O P · R A T E D
    func getTopRated(completion: @escaping blkGetTopRated) {
        guard let url = URL(string: "\(paths.topRated.rawValue)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let datos = data else { return }
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(TopRatedAPIResponse.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    //MARK: - G E T · U P C O M I N G
    func getUpcomgin(completion: @escaping blkGetUpcoming) {
        guard let url = URL(string: "\(paths.upcoming.rawValue)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let datos = data else { return }
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(UpcomingAPIResponse.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

}
