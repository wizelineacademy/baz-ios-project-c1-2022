//
//  MenuMoviesProtocols.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

protocol MenuMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MenuMoviesPresenterProtocol? { get set }
}

protocol MenuMoviesRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createMenuMoviesModule() -> UIViewController
}

protocol MenuMoviesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MenuMoviesViewProtocol? { get set }
    var interactor: MenuMoviesInteractorInputProtocol? { get set }
    var router: MenuMoviesRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol MenuMoviesInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol MenuMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MenuMoviesInteractorOutputProtocol? { get set }
    var localDatamanager: MenuMoviesLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MenuMoviesRemoteDataManagerInputProtocol? { get set }
}

protocol MenuMoviesDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol MenuMoviesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MenuMoviesRemoteDataManagerOutputProtocol? { get set }
}

protocol MenuMoviesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol MenuMoviesLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
