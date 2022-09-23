//
//  MovieAPI.swift
//  BAZProjectC1
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies(categoryMovieType category: CategoryMovieType, language lang: ApiLanguageResponse, handler: @escaping ([Movie]) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3\(category.endpoint)?api_key=\(apiKey)&language=\(lang.abbreviation)&page=1") else { return }
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

}

public enum CategoryMovieType:String {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var endpoint: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .upcoming:
            return "/movie/upcoming"
        }
    }
    
    var typeName: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

public enum ApiLanguageResponse:String {
    
    case es
    case en
    case de
    case pt
    
    var abbreviation: String {
        switch self {
        case .es:
            return "es"
        case .en:
            return "en"
        case .de:
            return "de"
        case .pt:
            return "pt"
        }
    }
    
    var fullName: String {
        switch self {
        case .es:
            return "Español"
        case .en:
            return "English"
        case .de:
            return "Deutsch"
        case .pt:
            return "Português"
        }
    }
}

struct MovieDay: Codable {
    let results: [Movie]
}
