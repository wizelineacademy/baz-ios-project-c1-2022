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
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    public func getGenres() -> String? {
        var genresString: String?
        guard let genreIds = genreIds else { return genresString }
        findGenre()
        return genresString
    }
    
    public func findGenre(){
        
        var Generes = ApiServiceRequest.decodeJsonDataTo(object: MoviesGenresList.self, with: EndpointsList.genreList.description.data(using: .utf8) ?? Data())
        print(Generes)
    }
}

public struct MoviesLanguage: Decodable {
    var iso6391: String?
    var english_name: String?
    var name: String?
}

public struct MoviesGenresList: Decodable {
    var genres: [MoviesGenre]?
}

public struct MoviesGenre: Decodable {
    var id: Int?
    var name: String?
}
