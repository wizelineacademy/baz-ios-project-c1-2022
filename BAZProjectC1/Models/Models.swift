//
//  Models.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

public struct MovieApiResponseModel: Decodable {
    var page: Int?
    var results: [MovieModel]?
    var totalPages: Int?
    var totalResults: Int?
    var dates: datesMovieModel?
}



public struct datesMovieModel: Decodable {
    var maximum:String?
    var minimum:String?
}

public struct MovieModel: Decodable {
    var adult: Bool?
    var backdropPath: String?
    var posterPath: String?
    var id: Int?
    var title: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var mediaType: String?
    var genreIds: [Int]?
    var genreIdsString: String?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    public func getGenresString() -> String? {
        var genresString: String = ""
        let genresList = MoviesGenresList()
        guard let moviesGenreIds = genreIds else { return genresString }
        moviesGenreIds.forEach({ genre in
            if let value = genresList.findGenre(withId: genre) {
                genresString = "\(String(describing: genresString)) | \(value)"
            }
        })
        return genresString
    }
    public func getGenresArray() -> [String] {
        var genresString: [String] = []
        let genresList = MoviesGenresList()
        guard let moviesGenreIds = genreIds else { return genresString }
        moviesGenreIds.forEach({ genre in
            if let value = genresList.findGenre(withId: genre) {
                genresString.append(value)
            }
        })
        return genresString
    }
    
    public func getLanguageString() -> String {
        var languagesString: String = ""
        let languagesList = MoviesLanguageList()
        guard let isoValue = originalLanguage,
              let value = languagesList.findlanguage(withIsoValue: isoValue)else {
                  return languagesString
              }
        languagesString = value
        return String(describing: languagesString)
    }
}

public struct MoviesLanguageList: Decodable {
    var languages: [MoviesLanguage]?
    
    init(){
        guard let urlData = EndpointsList.languagesList.description.data(using: .utf8),
              let languageInfoList = ApiServiceRequest.decodeJsonDataTo(object: MoviesLanguageList.self, with: urlData) as? MoviesLanguageList else { return }
        self = languageInfoList
    }
    public func findlanguage(withIsoValue value: String ) -> String? {
        languages?.first(where: { $0.iso6391 == value })?.name
    }
}

public struct MoviesLanguage: Decodable {
    var iso6391: String?
    var english_name: String?
    var name: String?
}

public struct MoviesGenresList: Decodable {
    var genres: [MoviesGenre]?
    init(){
        guard let urlData = EndpointsList.genreList.description.data(using: .utf8),
              let genreInfoList = ApiServiceRequest.decodeJsonDataTo(object: MoviesGenresList.self, with: urlData) as? MoviesGenresList else { return }
        self = genreInfoList
    }
    
    public func findGenre(withId id: Int) -> String? {
        genres?.first(where: { $0.id == id })?.name
    }
}

public struct MoviesGenre: Decodable {
    var id: Int?
    var name: String?
}
