//
//  Reviews.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 16/10/22.
//

import Foundation

struct Reviews: Codable{
    let author: String?
    let content: String?
    let author_details: AuthorDetails
}

struct AuthorDetails: Codable{
    let rating: Double?
}

struct ResponseReviews: Codable {
    var results: [Reviews]
}


