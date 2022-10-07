//  MovieAPI.swift
//  BAZProjectC1

import Foundation

final class MovieAPI {
    //MARK: - B L O C K
    public typealias blkSearch = (SearchAPIResult?, Error?) -> Void
    public typealias blkReview = (ReviewAPIResponse?, Error?) -> Void
    public typealias blkGetMovies = (MovieAPIResponse?, Error?) -> Void
    
    //MARK: - E N U M
    private enum paths: String {
        case trending = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case popular = "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        case search = "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&query="
    }
    
    private func returnAPI(from identifier:Int) -> String {
        switch identifier {
        case 1:
            return paths.trending.rawValue
        case 2:
            return paths.nowPlaying.rawValue
        case 3:
            return paths.popular.rawValue
        case 4:
            return paths.topRated.rawValue
        case 5:
            return paths.upcoming.rawValue
        case 6:
            return paths.search.rawValue
        default:
            return ""
        }
    }

    //MARK: - G E T · M O V I E · C A T E G O R I E S
    func getMoviesTrending(withId id:Int, completion: @escaping blkGetMovies) {
        guard let url = URL(string: returnAPI(from: id))  else { return }
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
    
    //MARK: - G E T · S E A R C H
    func searchMovie(with str: String, completion: @escaping blkSearch){
        guard let url = URL(string: "\(paths.search.rawValue)\(str)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let datos = data else { return }
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(SearchAPIResult.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    
    //MARK: - G E T · R E V I E W
    func getReview(withId str: String, completion: @escaping blkReview){
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(str)/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let datos = data else { return }
            do{
                let decoder = JSONDecoder()
                let data = try decoder.decode(ReviewAPIResponse.self, from: datos)
                completion(data, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

}
