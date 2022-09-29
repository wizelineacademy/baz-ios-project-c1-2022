//
//  DetailMovieProtocols.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DetailMoviePresenterProtocol? { get set }
}

protocol DetailMovieRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createDetailMovieModule() -> UIViewController
}

protocol DetailMoviePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorInputProtocol? { get set }
    var router: DetailMovieRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol DetailMovieInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol DetailMovieInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailMovieInteractorOutputProtocol? { get set }
    var localDatamanager: DetailMovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol? { get set }
}

protocol DetailMovieDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol DetailMovieRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol? { get set }
}

protocol DetailMovieRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol DetailMovieLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
