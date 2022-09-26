//
//  Models.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

public struct MovieApiResponseModel: Codable {
    var page: Int?
    var results: [MovieModel]?
    var totalPages: Int?
    var totalResults: Int?
    var dates: datesMovieModel?
}

public struct datesMovieModel: Codable {
    var maximum:String?
    var minimum:String?
}

public struct MovieModel: Codable {
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
}
