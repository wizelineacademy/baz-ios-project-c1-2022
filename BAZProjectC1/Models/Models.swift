//
//  Models.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation
import UIKit

public struct MovieApiResponseModel: Codable {
    var page: Int?
    var results: [MovieModel]?
    var total_pages: Int?
    var total_results: Int?
    var dates: datesMovieModel?
}

public struct datesMovieModel: Codable {
    var maximum:String?
    var minimum:String?
}

public struct MovieModel: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var poster_path: String?
    var id: Int?
    var title: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var media_type: String?
    var genre_ids: [Int]?
    var popularity: Double?
    var release_date: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

extension MovieModel {
    func posterImage(size: CGSize) -> UIImage {
        UIImage.imageFromColor(with: UIColor.appColorYellowPrimary.withAlphaComponent(0.1), size: size)
    }
    
    var imageURLString: String {
        "\(EndpointsList.imageResorce.description)\(poster_path ?? "")"
    }
    
    var movieRanking: String {
        "\(Int(vote_average ?? 0))"
    }
}
