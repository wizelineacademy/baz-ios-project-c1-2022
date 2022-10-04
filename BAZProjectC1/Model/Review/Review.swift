//  Review.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import Foundation

struct Review : Codable {
    let author : String?
    let authorDetails : AuthorDetails?
    let content : String?
    let createdAt : String?
    let id : String?
    let updatedAt : String?
    let url : String?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case authorDetails = "author_details"
        case content = "content"
        case createdAt = "created_at"
        case id = "id"
        case updatedAt = "updated_at"
        case url = "url"
    }
}
