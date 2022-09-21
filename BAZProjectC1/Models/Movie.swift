//
//  Movie.swift
//  BAZProjectC1
//
//

import Foundation
import UIKit

/// This is a model of movie
struct Movie {
    let id: Int
    let title: String
    let posterPath: String
    let posterImage: UIImage
}

typealias Movies = [Movie]
