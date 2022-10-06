//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation
import UIKit

struct Movie: Codable {
    var results: [DetailMovie] = []
    public init(){}
}

struct DetailMovie: Codable {
    var id: Int = 0
    var title: String = ""
    var poster_path: String = ""
    public init(){}
}
