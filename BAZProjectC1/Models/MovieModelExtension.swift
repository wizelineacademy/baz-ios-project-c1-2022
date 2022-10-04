//
//  MovieModelExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 04/10/22.
//

import Foundation
import UIKit

enum MediaTypeMovie: String  {
    case person = "person"
    case tv = "tv"
}

extension MovieModel {
    func getMoviePosterString() -> String? {
        guard let mediaType = mediaType else { return "" }
        switch MediaTypeMovie(rawValue: mediaType) {
        case .person:
            return profilePath
        default:
            return posterPath
        }
    }
    
    func getMovieTitleString() -> String {
        guard let mediaType = mediaType else { return "" }
        switch MediaTypeMovie(rawValue: mediaType) {
        case .person:
            return name ?? ""
        case .tv:
            return name ?? ""
        default:
            return title ?? ""
        }
    }
    
    func getMovieRankingString() -> String {
        guard let mediaType = mediaType else { return "" }
        switch MediaTypeMovie(rawValue: mediaType) {
        case .person:
            return "\(Int( round(popularity ?? 0)))"
        default:
            return "\(Int( round(voteAverage ?? 0))) (\(getLanguageString()))"
        }
    }
    
    public func getLanguageString() -> String {
        var languagesString: String = ""
        let languagesList = MoviesLanguageList()
        guard let isoValue = originalLanguage,
              let value = languagesList.findlanguage(withIsoValue: isoValue)else {
                  return languagesString
              }
        languagesString = value
        return String(describing: languagesString)
    }
    
    func getMovieGenreIdsString() -> String {
        guard let mediaType = mediaType else { return "" }
        switch MediaTypeMovie(rawValue: mediaType) {
        case .person:
            return name ?? ""
        default:
            return title ?? ""
        }
    }
}
