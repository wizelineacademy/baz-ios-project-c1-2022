//
//  DetailMovieInteractor.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class DetailMovieInteractor: DetailMovieInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: DetailMovieInteractorOutputProtocol?
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol?
    
    // MARK: - DetailMovieInteractorInputProtocol functions
    func getMovieSimilar(idMovie: Int) {
        remoteDatamanager?.getMovieSimilar(idMovie: idMovie)
    }
    
    func getMovieDetail(idMovie: Int) {
        remoteDatamanager?.getMovieDetail(idMovie: idMovie)
    }
}

// MARK: - DetailMovieRemoteDataManagerOutputProtocol
extension DetailMovieInteractor: DetailMovieRemoteDataManagerOutputProtocol {
    
    // MARK: - DetailMovieRemoteDataManagerOutputProtocol functions
    func pushSimilarMoviesData(similarMoviesData: [Movie]) {
        presenter?.pushSimilarMoviesData(similarMoviesData: similarMoviesData)
    }
    
    func pushMovieDetailData(movieData: MovieDetail) {
        presenter?.pushMovieDetailData(movieData: movieData)
    }
    
    func catchResponse(withMessage: String) {
        presenter?.catchResponse(withMessage: withMessage)
    }
}
