//
//  Models.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation
import UIKit

public struct MovieApiResponseModel: Decodable {

    var page: Int?
    var results: [MovieModel]?
    var totalPages: Int?
    var totalResults: Int?
    var dates: DatesMovieModel?
}

public struct DatesMovieModel: Decodable {
    var maximum: String?
    var minimum: String?
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
    
    //MARK: for Actor info
    
    var knownFor: [MovieModel]?
    var knownForDepartment: String?
    var name: String?
    var profilePath: String?
}

public struct MoviesLanguageList: Decodable {
    var languages: [MoviesLanguage]?
    
    init(){
        guard let urlData = EndpointsList.languagesList.description.data(using: .utf8),
              let languageInfoList = ApiServiceRequest.decodeJsonData(to: MoviesLanguageList.self, with: urlData) as? MoviesLanguageList else { return }
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
              let genreInfoList = ApiServiceRequest.decodeJsonData(to: MoviesGenresList.self, with: urlData) as? MoviesGenresList else { return }
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

//MARK:  CAST MODEL

public struct CastApiResponseModel: Decodable {
    var id: Int?
    var cast: [CastModel]?
}

public struct CastModel: Decodable {
    var adult: Bool?
    var gender: Int?
    var id: Int?
    var knownForDepartment: String?
    var name: String?
    var originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castId: Int?
    var character: String?
    var creditId: String?
    var order: Int?
}

extension CastModel {
    
    func getMoviePosterString() -> String? {
        return profilePath
    }
    
    func getMovieTitleString() -> String {
        let name =  name ?? ""
        
        return "\(name) \n(\(character ?? ""))"
    }

    func getMovieRankingString() -> String {
        let popularity = Int( round(popularity ?? 0))
        return "\(popularity)"
    }
    
    
}
    
