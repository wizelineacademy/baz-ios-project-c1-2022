//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

struct Movie {
    let id: Int
    let title: String
    let descriptionMovie: String
    let posterPath: String
    var imageDetail: String {
        "\(tmdbImageStringURLPrefix)\(self.posterPath)"
    }
}

struct MenuRow {
    let title: String
    let detail: String
    let image: String
}

struct ResultParser : Decodable {
    var page: Int?
    var results: [MovieUpdate]?
    var totalPages: Int?
    var totalResults: Int?
}

struct MovieUpdate : Decodable {
    var id: Int?
    var mediaType: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
}
