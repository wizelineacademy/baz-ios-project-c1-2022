//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    func getMoviesTrending(completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    
    func getMoviesPopular(completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    
    func getMoviesTopRated(completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    
    func getMoviesUpcoming(completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    
    
    func getMoviesNowPlaying(completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    
    
    func getMoviesSimilar(id: Int, completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
            }
        }.resume()
    }
    
    
    func getVideoMovie(id: Int, completion: @escaping (([Video]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseVideo.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
                completion([Video]())
            }
        }.resume()
    }
    
}
