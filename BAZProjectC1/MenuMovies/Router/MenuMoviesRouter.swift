//
//  MenuMoviesRouter.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

class MenuMoviesRouter: MenuMoviesRouterProtocol {

    class func createMenuMoviesModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MenuMoviesView")
        if let view = navController.children.first as? MenuMoviesView {
            let presenter: MenuMoviesPresenterProtocol & MenuMoviesInteractorOutputProtocol = MenuMoviesPresenter()
            let interactor: MenuMoviesInteractorInputProtocol & MenuMoviesRemoteDataManagerOutputProtocol = MenuMoviesInteractor()
            let localDataManager: MenuMoviesLocalDataManagerInputProtocol = MenuMoviesLocalDataManager()
            let remoteDataManager: MenuMoviesRemoteDataManagerInputProtocol = MenuMoviesRemoteDataManager()
            let router: MenuMoviesRouterProtocol = MenuMoviesRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MenuMoviesView", bundle: Bundle.main)
    }
    
}
