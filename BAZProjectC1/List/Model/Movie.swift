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
