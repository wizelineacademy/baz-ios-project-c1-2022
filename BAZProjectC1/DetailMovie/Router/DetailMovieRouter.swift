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
    
    // MARK: - Create Module DetailMovieModule
    class func createDetailMovieModule(movieDetailData: MovieDetail) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailMovieView")
        if let view = viewController as? DetailMovieView {
            let presenter: DetailMoviePresenterProtocol & DetailMovieInteractorOutputProtocol = DetailMoviePresenter()
            let interactor: DetailMovieInteractorInputProtocol & DetailMovieRemoteDataManagerOutputProtocol = DetailMovieInteractor()
            let remoteDataManager: DetailMovieRemoteDataManagerInputProtocol = DetailMovieRemoteDataManager()
            let router: DetailMovieRouterProtocol = DetailMovieRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.movieDetailData = movieDetailData
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    // MARK: - Properties
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "DetailMovieStoryboard", bundle: nil)
    }
    
    /**
     Function that calls the movie detail view to show next.
     */
    func goToMovieDetail(movieDetailData: MovieDetail, view: DetailMovieViewProtocol) {
        if let newView = view as? UIViewController {
            DispatchQueue.main.async {
                let movieDatail = DetailMovieRouter.createDetailMovieModule(movieDetailData: movieDetailData)
                newView.navigationController?.pushViewController(movieDatail, animated: true)
            }
        }
    }
    
    
}
