//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

final class MovieAPI {
    
    func getMovies(completion: @escaping ([Movie])->()){
        load(.trendingMovie, completion: completion)
    }
    
    func load(_ endPoint: EndPoint, completion: @escaping ([Movie])-> Void) {
        let url = endPoint.requestFrom
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

func performNetworkRequest(url: String, completion: @escaping (Data?, Error?) -> Void) {
    // create a url
    let requestUrl = URL(string: url)
    
    // create a data task
    let task = URLSession.shared.dataTask(with: requestUrl!) { (data, response, error) in
        completion(data, error)
    }
    task.resume()
}


func moviesRequest (requestUrl: URLRequest, completion: @escaping (Data?, Error?) -> Void){
    let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
        completion(data, error)
    }
    task.resume()
}
