//
//  Constants.swift
//  BAZProjectC1
//
//  Created by rnunezi on 03/10/22.
//

import Foundation
import UIKit

//MARK: - ConstantsDetailMovies

enum ConstantsDetailMovies {
    static let titleCollection = String.localized( "title.movieCollectionViewController")
    static let titleDetail = String.localized( "title.detailMoviesViewController")
    static let titleFavoriteCollection = String.localized( "title.favoriteMovieCollectionViewController")
    static let titleButtonAddMovies = String.localized( "title.detailMoviesViewController.buttonAddMovies")
    static let titleButtonRemoveMovies = String.localized( "title.detailMoviesViewController.buttonRemoveMovies")
}

//MARK: - ConstantsLayoutMovieCollection

enum ConstantsLayoutMovieCollection {
    static let numberOfSections:Int = 1
    static let insets: CGFloat = 8
    static let heightAditionalConstant : CGFloat = 45
    static let minimumLineSpacing: CGFloat = 10
    static let minimumInteritemSpacing: CGFloat = 10
    static let cellsPerRow:Int = 2
}

//MARK: - ConstantsApi

enum ConstantsApi {
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let urlAPI: String = "https://api.themoviedb.org/3/trending/movie/"
    static let urlBase = "https://image.tmdb.org/t/p/w500"
}
