//
//  MovieDetail.swift
//  BAZProjectC1
//
//  Created by Mayte LA on 03/10/22.
//

import UIKit

struct ResultMovie: Codable {
    let result: MovieDetail
}

struct MovieDetail: Codable {
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let title: String
    let voteAverage: Double
    let credits: Credits
    let recommendations: Recommendations
    let similar: Recommendations
    let reviews: Reviews
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case credits
        case recommendations
        case similar
        case reviews
    }
}

struct Credits: Codable {
    let cast: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
    }
}

// MARK: - Recommendations
struct Recommendations: Codable {
    let page: Int
    let results: [RecommendationsResult]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

// MARK: - RecommendationsResult
struct RecommendationsResult: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let page: Int
    let results: [ReviewsResult]
}

// MARK: - ReviewsResult
struct ReviewsResult: Codable {
    let author: String
    let content: String
}
