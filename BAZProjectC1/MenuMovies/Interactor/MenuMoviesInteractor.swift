//
//  MenuMoviesInteractor.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class MenuMoviesInteractor: MenuMoviesInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: MenuMoviesInteractorOutputProtocol?
    var remoteDatamanager: MenuMoviesRemoteDataManagerInputProtocol?

    // MARK: - MenuMoviesInteractorInputProtocol functions
    func getMovies(categoryMovieType: CategoryMovieType) {
        remoteDatamanager?.getMovies(categoryMovieType: categoryMovieType)
    }
    
    func getSearchedMovies(searchTerm: String) {
        remoteDatamanager?.getSearchedMovies(searchTerm: searchTerm)
    }
    
    func getMovieDetail(idMovie: Int) {
        remoteDatamanager?.getMovieDetail(idMovie: idMovie)
    }
    
    
}

// MARK: - MenuMoviesRemoteDataManagerOutputProtocol
extension MenuMoviesInteractor: MenuMoviesRemoteDataManagerOutputProtocol {
    
    // MARK: - MenuMoviesRemoteDataManagerOutputProtocol functions
    func pushSearchedMoviesData(moviesData: [Movie]) {
        presenter?.pushSearchedMoviesData(moviesData: moviesData)
    }
    
    func pushMoviesData(moviesData: [Movie]) {
        presenter?.pushMoviesData(moviesData: moviesData)
    }
    
    func pushMovieDetailData(movieData: MovieDetail) {
        presenter?.pushMovieDetailData(movieData: movieData)
    }
    
    func catchResponse(withMessage: String) {
        presenter?.catchResponse(withMessage: withMessage)
    }

}
