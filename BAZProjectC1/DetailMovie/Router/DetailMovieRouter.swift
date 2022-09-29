//
//  DetailMovieRouter.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation
import UIKit

class DetailMovieRouter: DetailMovieRouterProtocol {

    class func createDetailMovieModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DetailMovieView")
        if let view = navController.children.first as? DetailMovieView {
            let presenter: DetailMoviePresenterProtocol & DetailMovieInteractorOutputProtocol = DetailMoviePresenter()
            let interactor: DetailMovieInteractorInputProtocol & DetailMovieRemoteDataManagerOutputProtocol = DetailMovieInteractor()
            let localDataManager: DetailMovieLocalDataManagerInputProtocol = DetailMovieLocalDataManager()
            let remoteDataManager: DetailMovieRemoteDataManagerInputProtocol = DetailMovieRemoteDataManager()
            let router: DetailMovieRouterProtocol = DetailMovieRouter()
            
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
        return UIStoryboard(name: "DetailMovieView", bundle: Bundle.main)
    }
    
}
