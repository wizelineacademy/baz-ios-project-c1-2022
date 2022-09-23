//
//  MovieDetail.swift
//  BAZProjectC1
//
//  Created by 1030361 on 23/09/22.
//

import Foundation

internal struct MovieDetailResults: Decodable {
    let id, page: Int
    let results: [MovieDetail]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

internal struct MovieDetail: Decodable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

internal struct AuthorDetails: Decodable {
    let name, username: String
}
