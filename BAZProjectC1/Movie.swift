//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation

/// This is a model of movie
struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
}

typealias Movies = [Movie]
