//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let selectedLanguage:ApiLanguageResponse = {
        if let data = UserDefaults.standard.object(forKey: "SelectedLanguageResponse") as? Data,
           let selectedLanguage = try? JSONDecoder().decode(ApiLanguageResponse.self, from: data) {
             return selectedLanguage
        }
        return .es
    }()

    func getMovies(categoryMovieType category: CategoryMovieType, handler: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3\(category.endpoint)?api_key=\(apiKey)&language=\(selectedLanguage.rawValue)&page=1") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDay.self, from: data)
                handler(result.results)
            }catch {
                print("catch: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getMovieDetail(idMovie id: Int, handler: @escaping (MovieDetail) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)&language=\(selectedLanguage.rawValue)&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                handler(result)
            }catch {
                print("catch: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func getMovieSimilar(idMovie id: Int, handler: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/similar?api_key=\(apiKey)&language=\(selectedLanguage.rawValue)&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDay.self, from: data)
                handler(result.results)
            }catch {
                print("catch: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func searchMovie(searchTerm query: String, handler: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/multi?api_key=\(apiKey)&language=\(selectedLanguage.rawValue)&query=\(query)&page=1") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("error: \(error?.localizedDescription ?? "error")")
                return
            }
            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(MovieDay.self, from: data)
                var movieData = result.results
                movieData = movieData.filter({$0.media_type == "movie"})
                handler(movieData)
            }catch {
                print("catch: \(error.localizedDescription)")
            }
        }.resume()
    }
    
}

