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
    var localDatamanager: DetailMovieLocalDataManagerInputProtocol?
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol?

}

extension DetailMovieInteractor: DetailMovieRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
