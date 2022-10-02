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

    // MARK: - Create Module MenuMovies
    
    class func createMenuMoviesModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MenuMoviesView")
        if let view = navController.children.first as? MenuMoviesView {
            let presenter: MenuMoviesPresenterProtocol & MenuMoviesInteractorOutputProtocol = MenuMoviesPresenter()
            let interactor: MenuMoviesInteractorInputProtocol & MenuMoviesRemoteDataManagerOutputProtocol = MenuMoviesInteractor()
            let remoteDataManager: MenuMoviesRemoteDataManagerInputProtocol = MenuMoviesRemoteDataManager()
            let router: MenuMoviesRouterProtocol = MenuMoviesRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    // MARK: - Properties
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MenuMoviesView", bundle: nil)
    }
    
    /**
     Function that calls the movie detail view to show next.
     */
    func goToMovieDetail(movieDetailData: MovieDetail, view: MenuMoviesViewProtocol) {
        if let newView = view as? UIViewController {
            DispatchQueue.main.async {
                let movieDatail = DetailMovieRouter.createDetailMovieModule(movieDetailData: movieDetailData)
                newView.navigationController?.pushViewController(movieDatail, animated: true)
            }
        }
    }
}
