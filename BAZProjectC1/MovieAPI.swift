//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {
// MARK:  - base parameter declaration
    private let baseURLPath: String = "https://api.themoviedb.org/3"
    private let apiKey: String
    
    public init(apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a") {
        self.apiKey = apiKey
    }

    func getMovies() -> [Movie] {
        guard let url = URL(string: "\(baseURLPath)/trending/movie/day?api_key=\(apiKey)"),
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
               let poster_path = result.object(forKey: "poster_path") as? String, let strDetail = result.object(forKey: "overview") as? String {
                movies.append(Movie(id: id, title: title, descriptionMovie: strDetail, posterPath: poster_path))
            }
        }
        return movies
    }
    
    public func getNowPlaying() {
        
      request(strUrlPath: "\(baseURLPath)/movie/now_playing?api_key=\(apiKey)", completion: { lstInfo in
            NotificationCenter.default.post(name: Notification.Name("notificationNowPlay"), object: ["infoData":lstInfo])
        })
    }
    
    /**
        * this method consults the list of movies
        * executes the "request" function which requests a url to be able to execute the request
        * completion:  the closure returns the list of movies
     */
    func getMoviesUpdate(completion: @escaping ([MovieUpdate]) -> ()) {
        request(strUrlPath: "\(baseURLPath)/trending/movie/day?api_key=\(apiKey)", completion: completion)
    }
    
    public func getMostPopular(completion: @escaping ([MovieUpdate]) -> ()) {
       request(strUrlPath:"\(baseURLPath)/movie/popular?api_key=\(apiKey)&language=es&region=MX&page=1", completion: completion)
    }
    
    /**
     * this method consults the list of movies top rated
     * executes the "request" function which requests a url to be able to execute the request
     * completion:  the closure returns the list of movies top rated
     */
    func getTopRated(completion: @escaping ([MovieUpdate]) -> ()) {
        request(strUrlPath:"\(baseURLPath)/movie/top_rated?api_key=\(apiKey)&language=es&region=MX&page=1", completion: completion)
    }
    
    /**
     * this method consults the list of movies UpComing
     * executes the "request" function which requests a url to be able to execute the request
     * completion:  the closure returns the list of movies UpComing
     */
    func getUpComing(completion: @escaping ([MovieUpdate]) -> ()) {
       request(strUrlPath:"\(baseURLPath)/movie/upcoming?api_key=\(apiKey)&language=es&region=MX&page=1", completion: completion)
    }
    
    func getQuery(strQuery: String, completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "\(baseURLPath)/search/keyword?api_key=\(apiKey)&language=es&query=\(strQuery)") else {
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
                            lstMovies.append(Movie(id: item["id"] as? Int ?? 0, title: item["name"] as? String ?? "", descriptionMovie: item["overview"] as? String ?? "", posterPath: item["poster_path"] as? String ?? ""))
                        }
                    }
                    completion(lstMovies)
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    
    
    /**
     * this method consults the list of movies Query Search
     * executes the "request" function which requests a url to be able to execute the request
     * completion:  the closure returns specifie Movie
     */
    func getQuerySearch(strQuery: String, completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"\(baseURLPath)/search/movie?api_key=\(apiKey)&language=es&page=2&query=\(strQuery)", completion: completion)
        
    }
    
    /**
     * this method consults the list of movies QuerySearch
     * executes the "request" function which requests a url to be able to execute the request
     * completion:  the closure returns specifie Movie
     */
    func getReviews(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"\(baseURLPath)/movie/603/reviews?api_key=\(apiKey)&language=es", completion: completion)
    }

    func getSimilar(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "\(baseURLPath)/movie/603/similar?api_key=\(apiKey)&language=es", completion: completion)
        
    }
    
    func getRecomendations(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "\(baseURLPath)/movie/603/recommendations?api_key=\(apiKey)&language=es", completion: completion)
    }
    
    // MARK: New Serializacion
    private func serializationNewJSON(objData: Data) -> ResultParser {
        let objJD = JSONDecoder()
        objJD.keyDecodingStrategy = .convertFromSnakeCase
        let objDatos = try? objJD.decode(ResultParser.self, from: objData)
        return objDatos ?? ResultParser()
    }
    
    //MARK: Request
    private func request(strUrlPath: String, completion: @escaping ([MovieUpdate]) -> ()) {
        guard let url = URL(string: strUrlPath) else {
            return
        }
       
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let obj = self.serializationNewJSON(objData: data)
                completion(obj.results ?? [MovieUpdate]())
            }
        }.resume()
        
    }
}

