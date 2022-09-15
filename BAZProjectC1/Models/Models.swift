//
//  Models.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation

public struct MovieApiResponseModel: Codable {
    let page: Int
    let results: [MovieModel]
    let total_pages: Int
    let total_results: Int
}
public struct MovieModel: Codable {
    let adult: Bool
    let backdrop_path: String
    let id: Int
    let title: String
    let original_language: String
    let original_title: String
    let overview: String
    let media_type: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
