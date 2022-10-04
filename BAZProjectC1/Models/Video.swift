//
//  Video.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 03/10/22.
//

import Foundation

struct Video: Codable{
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let published_at: String
    let id: String
}

struct ResponseVideo: Codable {
    var results: [Video]
}
