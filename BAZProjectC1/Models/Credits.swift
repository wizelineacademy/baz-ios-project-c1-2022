//
//  Credits.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 17/10/22.
//

import Foundation

struct Actor: Codable{
    let original_name: String
    let character: String
    let order: Int
    let profile_path: String?
}

struct ResponseCredits: Codable {
    var cast: [Actor]
}
