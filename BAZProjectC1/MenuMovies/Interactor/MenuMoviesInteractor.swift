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
    var localDatamanager: MenuMoviesLocalDataManagerInputProtocol?
    var remoteDatamanager: MenuMoviesRemoteDataManagerInputProtocol?

}

extension MenuMoviesInteractor: MenuMoviesRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
