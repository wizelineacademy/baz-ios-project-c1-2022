//
//  MenuMoviesPresenter.swift
//  BAZProjectC1
//
//  Created by 961184 on 26/09/22.
//  
//

import Foundation

class MenuMoviesPresenter: MenuMoviesPresenterProtocol  {
    
    // MARK: Properties
    weak var view: MenuMoviesViewProtocol?
    var interactor: MenuMoviesInteractorInputProtocol?
    var router: MenuMoviesRouterProtocol?
    
    var selectedCategory: CategoryMovieType?
    var selectedLanguage: ApiLanguageResponse?
    
    private var movies: [Movie] = []
    private var searchResult: [Movie] = []
    
    
    func viewDidLoad(){
        interactor?.getMovies(categoryMovieType: selectedCategory ?? .trending)
    }
    
    // MARK: - MenuMoviesPresenterProtocol Functions
    func getMovieCount() -> Int {
        return self.movies.count
    }
    
    func getMovie(indexPathRow: Int) -> Movie {
        return movies[indexPathRow]
    }
    
    func getSearchedMovieCount() -> Int {
        return self.searchResult.count
    }
    
    func getSearchedMovie(indexPathRow: Int) -> Movie {
        return self.searchResult[indexPathRow]
    }
    
    func getSearchedMovies(searchTerm: String) {
        interactor?.getSearchedMovies(searchTerm: searchTerm)
    }
    
    func getMovieDetail(idMovie: Int) {
        interactor?.getMovieDetail(idMovie: idMovie)
    }
    
}

// MARK: - MenuMoviesInteractorOutputProtocol
extension MenuMoviesPresenter: MenuMoviesInteractorOutputProtocol {
    
    // MARK: - MenuMoviesInteractorOutputProtocol functions
    func pushSearchedMoviesData(moviesData: [Movie]) {
        self.searchResult = moviesData
        
        self.view?.reloadCollectionViewSearchedData()
    }
    
    func pushMoviesData(moviesData: [Movie]) {
        self.movies = moviesData
        self.view?.reloadCollectionViewData()
    }
    
    func pushMovieDetailData(movieData: MovieDetail) {
        if let view = view{
            self.view?.catchResponse(withMessage: nil)
            self.router?.goToMovieDetail(movieDetailData: movieData, view: view)
        }
    }
    
    func catchResponse(withMessage: String) {
        self.view?.catchResponse(withMessage: withMessage)
    }
    
}
