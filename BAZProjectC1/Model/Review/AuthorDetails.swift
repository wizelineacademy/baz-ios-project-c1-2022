//  AuthorDetails.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import Foundation

struct AuthorDetails : Codable {
    let name : String?
    let username : String?
    let avatar_path : String?
    let rating : Double?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "username"
        case avatar_path = "avatar_path"
        case rating = "rating"
    }
}
