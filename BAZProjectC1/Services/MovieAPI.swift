//  MovieAPI.swift
//  BAZProjectC1

import Foundation

final class MovieAPI {
    //MARK: - B L O C K
    public typealias blkSearch = (SearchAPIResult?, Error?) -> Void
    public typealias blkReview = (ReviewAPIResponse?, Error?) -> Void
    public typealias blkGetMovies = (MovieAPIResponse?, Error?) -> Void

    //MARK: - G E T · M O V I E · C A T E G O R I E S
    func getMoviesCategory(withURL category:String , completion: @escaping blkGetMovies) {
        guard let url = URL(string: category)  else { return }
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
        guard let url = URL(string: "\(MovieCategory.search.rawValue)\(str)") else { return }
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
    
    //MARK: - G E T · S I M I L A R
    func getSimilar(withId str:String, completion: @escaping blkGetMovies) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(str)/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a") else { return }
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

}
