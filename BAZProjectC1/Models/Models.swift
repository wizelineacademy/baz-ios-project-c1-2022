//
//  Models.swift
//  BAZProjectC1
//
//  Created by 1044336 on 15/09/22.
//

import Foundation
import UIKit

public struct MovieApiResponseModel: Decodable {
    var page: Int?
    var results: [MovieModel]?
    var totalPages: Int?
    var totalResults: Int?
    var dates: DatesMovieModel?
}

public struct DatesMovieModel: Decodable {
    var maximum: String?
    var minimum: String?
}

public struct MovieModel: Decodable {
    var adult: Bool?
    var backdropPath: String?
    var posterPath: String?
    var id: Int?
    var title: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var mediaType: String?
    var genreIds: [Int]?
    var genreIdsString: String?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    //MARK: for Actor info
    
    var knownFor: [MovieModel]?
    var knownForDepartment: String?
    var name: String?
    var profilePath: String?
}

extension MovieModel {
    func posterImage(size: CGSize) -> UIImage {
        UIImage.imageFromColor(with: UIColor.appColorYellowPrimary.withAlphaComponent(0.1), size: size)
    }
    
    var imageURLString: String {
        "\(EndpointsList.imageResorce.description)\(posterPath ?? "")"
    }
    
    var movieRanking: String {
        "\(Int(voteAverage ?? 0))"
    }
}
