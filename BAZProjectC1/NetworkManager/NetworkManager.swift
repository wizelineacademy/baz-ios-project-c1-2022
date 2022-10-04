//
//  NetworkManager.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 23/09/22.
//

import Foundation


enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

struct NetworkManager {
    
    private let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    /**
     Function that creates a request via url
     - Parameters:
     - url: Element equivalent to url
     - Returns: URLRequest?. Request with specific configuration
     */    
    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    /**
     Generic function that executes a request
     - Parameters:
     - request: Request of type URLRequest
     - completion: Closure that receives two parameters: generic typet and the error
     */
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
    
    
    typealias MovieCompletionClosure = ((Movie?, Error?) -> Void)
    typealias CastCompletionClosure = ((MovieCast?,Error?) -> Void)
    typealias SearchCompletionClosure = ((SearchMovie?,Error?) -> Void)
    /**
     Function tthat obtains the data of the movies
     - Parameters:
     - completion: Closure define in typealias
     */
    public func fetchMovieTrending(completion: MovieCompletionClosure?) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)&language=es-MX") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    public func fetchMovieFilter(completion: MovieCompletionClosure?, filter: String) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/movie/\(filter)?api_key=\(apiKey)&language=es-MX") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func fetchMovieDetail(completion: MovieCompletionClosure?, movieId: Int, filter: String) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/movie/\(movieId)/\(filter)?api_key=\(apiKey)&language=es-MX") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func fetchMovieCast(completion: CastCompletionClosure?, movieId: Int) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=\(apiKey)&language=es-MX") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func fetchMovieSearch(completion: SearchCompletionClosure?, keyword: String) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/search/multi?api_key=\(apiKey)&query=\(keyword)&language=es-MX") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func fetchMovieInfo(completion: MovieCompletionClosure?, movieId: Int) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/movie/\(String(movieId))?api_key=\(apiKey)&language=es-MX") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
}

