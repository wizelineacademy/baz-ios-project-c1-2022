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
               let poster_path = result.object(forKey: "poster_path") as? String, let strDetail = result.object(forKey: "overview") as? String {
                movies.append(Movie(id: id, title: title, descriptionMovie: strDetail, posterPath: poster_path))
            }
        }
        return movies
    }
    
    func getMoviesUpdate(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)", completion: {  lstInfo in
            
            completion(lstInfo)
        })
    }
    func getMoviesUpdateNew(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)", completion: { lstInfo in

            //print("Info lst: \(lstInfo)")
            completion(lstInfo)
        })
    }
     
    func getNowPlaying(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)", completion: { lstInfo in
            
            completion(lstInfo)
        })
    }

    func getMostPopular(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=es&region=MX&page=1", completion: { lstInfo in
            
            completion(lstInfo)
        })
    }
    
    func getTopRated(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=es&region=MX&page=1", completion: { lstInfo in

            completion(lstInfo)
        })
    }
    
    func getUpComing(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)&language=es&region=MX&page=1", completion: { lstInfo in
            
            completion(lstInfo)
        })
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
    
    func getQuerySearch(strQuery: String, completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=es&page=2&query=\(strQuery)", completion: { lstInfo in
            
            completion(lstInfo)
        })
        
    }
    
    func getReviews(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath:"https://api.themoviedb.org/3/movie/603/reviews?api_key=\(apiKey)&language=es", completion: { lstInfo in
            
            completion(lstInfo)
        })
    }

    func getSimilar(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "https://api.themoviedb.org/3/movie/603/similar?api_key=\(apiKey)&language=es", completion: { lstInfo in
            completion(lstInfo)
        })
        
    }
    
    func getRecomendations(completion: @escaping ([MovieUpdate]) -> ()) {
        self.request(strUrlPath: "https://api.themoviedb.org/3/movie/603/recommendations?api_key=\(apiKey)&language=es", completion: {  lstInfo in
            
            completion(lstInfo)
        })
    }
    
    /*
    //MARK: Serializacion
    func serializationJson(jsonDic: Any) -> [Movie] {
        var lstMovies = [Movie]()
        if let dataInfo = jsonDic as? [String : Any], let dataAll = dataInfo["results"] as? [[String: Any]]{
            for item in dataAll {
                lstMovies.append(Movie(id: item["id"] as? Int ?? 0, title: item["title"] as? String ?? "", descriptionMovie: item["overview"] as? String ?? "", posterPath: item["poster_path"] as? String ?? ""))
            }
        }
        return lstMovies
    }
    
    //MARK: Request
    func request(strUrlPath: String, completion: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: strUrlPath) else {
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print("Json: \(json)")
                    completion(self.serializationJson(jsonDic: json))
                } catch {
                    completion([])
                }
                
            }
        }.resume()
    }
    */
    
    // MARK: New Serializacion
    func serializationNewJSON(objData: Data) -> ResultParser {
        let objJD = JSONDecoder()
        objJD.keyDecodingStrategy = .convertFromSnakeCase
        let objDatos = try? objJD.decode(ResultParser.self, from: objData)
        return objDatos ?? ResultParser()
    }
    
    //MARK: Request
    func request(strUrlPath: String, completion: @escaping ([MovieUpdate]) -> ()) {
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

