//
//  MovieDetail.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let original_language, original_title, overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let release_date: String?
    let revenue, runtime: Int?
    let spoken_languages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logo_path, name, origin_country: String?
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let name: String?
}
