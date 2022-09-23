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
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                completion(self.serializationJson(jsonDic: json))
            } catch {
                completion([])
            }
        }.resume()
        
    }
    
    
    //////Nuevos servicios
    func getNowPlaying(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)") else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                   completion([])
                }
                
            }
        }.resume()
    }

    func getMostPopular(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    func getTopRated(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    func getUpComing(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    func getQuery(strQuery: String, completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/keyword?api_key=\(apiKey)&language=es&query=\(strQuery)") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    var lstMovies = [Movie]()
                    
                    if let dataInfo = json as? [String : Any], let dataAll = dataInfo["results"] as? [[String: Any]]{
                        
                        for item in dataAll {
                            lstMovies.append(Movie(id: item["id"] as? Int ?? 0, title: item["name"] as? String ?? "", poster_path: ""))
                        }
                    }
                    completion(lstMovies)
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    func getQuerySearch(strQuery: String, completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=es&page=2&query=\(strQuery)") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    func getReviews(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/603/reviews?api_key=\(apiKey)&language=es") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }

    func getSimilar(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/603/similar?api_key=\(apiKey)&language=es") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    func getRecomendations(completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/603/recommendations?api_key=\(apiKey)&language=es") else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    //MARK: Serializacion
    func serializationJson(jsonDic: Any) -> [Movie] {
        var lstMovies = [Movie]()
        if let dataInfo = jsonDic as? [String : Any], let dataAll = dataInfo["results"] as? [[String: Any]]{
            for item in dataAll {
                lstMovies.append(Movie(id: item["id"] as? Int ?? 0, title: item["title"] as? String ?? "", poster_path: item["poster_path"] as? String ?? ""))
            }
        }
        return lstMovies
    }
}
