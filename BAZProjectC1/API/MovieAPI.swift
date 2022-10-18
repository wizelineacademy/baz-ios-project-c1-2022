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
                completion([Movie]())
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
                completion([Movie]())
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
                completion([Movie]())
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
                completion([Movie]())
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
                completion([Movie]())
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
                completion([Movie]())
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
    
    func getReviews(id: Int, completion: @escaping (([Reviews]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseReviews.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
                completion([Reviews]())
            }
        }.resume()
    }
    
    func getCredits(id: Int, completion: @escaping (([Actor]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseCredits.self, from: data)
                completion(res.cast)
            } catch let error {
                print("Error: ", error)
                completion([Actor]())
            }
        }.resume()
    }
    
    func getRecommendations(id: Int, completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(apiKey)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
                completion([Movie]())
            }
        }.resume()
    }
    
    func getSearch(keyword: String, completion: @escaping (([Movie]) -> Void)) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(keyword)")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let res = try JSONDecoder().decode(ResponseMovie.self, from: data)
                completion(res.results)
            } catch let error {
                print("Error: ", error)
                completion([Movie]())
            }
        }.resume()
    }
    
}
