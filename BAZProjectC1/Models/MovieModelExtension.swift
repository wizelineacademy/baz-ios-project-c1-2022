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
        switch MediaTypeMovie(rawValue: mediaType ?? "") {
        case .person:
            return profilePath
        default:
            return posterPath
        }
    }
    
    func getMovieTitleString() -> String {
        switch MediaTypeMovie(rawValue: mediaType ?? "") {
        case .person:
            return name ?? ""
        case .tv:
            return name ?? ""
        default:
            return title ?? ""
        }
    }
    
    func getMovieRankingString() -> String {
        switch MediaTypeMovie(rawValue: mediaType ?? "") {
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
        switch MediaTypeMovie(rawValue: mediaType ?? "") {
        case .person:
            return name ?? ""
        default:
            return title ?? ""
        }
    }
    
    public func getGenresArray() -> [String] {
        var genresString: [String] = []
        let genresList = MoviesGenresList()
        guard let moviesGenreIds = genreIds else { return genresString }
        moviesGenreIds.forEach({ genre in
            if let value = genresList.findGenre(withId: genre) {
                genresString.append(value)
            }
        })
        return genresString
    }
    
}
