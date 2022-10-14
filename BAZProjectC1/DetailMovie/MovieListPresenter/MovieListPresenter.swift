//
//  MovieListPresenter.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import UIKit

final class MovieListPresenter {
    
    private var movie:MovieListProtocol = MovieList()
    private var similarMovies = Movie(results: [MovieData]())
    private var recommendsMovies = Movie(results: [MovieData]())
    private let reuseIndentifier = "CollectionViewMovie"
    private weak var view: MovieDetailController?
    
    init(view: MovieDetailController) {
        self.view = view
    }
    
    
    public func loadDataSimilar(using collectionView: UICollectionView, movieId: Int) {
            movie.loadMoviesDetail(with: MovieListType.similar.rawValue, completion: { (movie) in
                self.similarMovies = movie
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }, movieId)
    }
    
    public func loadDataRecomendadas(using collectionView: UICollectionView, movieId: Int) {
            movie.loadMoviesDetail(with: "recommendations", completion: { (movie) in
                self.recommendsMovies = movie
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }, movieId)
    }
    private func openDetails(for asset: MovieData, with rail: Movie, using viewController: UIViewController) {
        view?.presentView(for: asset)
    }
    public func getMovies(forRow row: Int, using collectionView: UICollectionView, forPresent viewController: UIViewController, typeOfMovie: String) -> UICollectionViewCell {
        switch typeOfMovie {
        case MovieListType.similar.rawValue :
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: IndexPath(row: row, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            collectionCell.loadData(movies: similarMovies)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
            return collectionCell
        case MovieListType.recommendation.rawValue:
            guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: IndexPath(row: row, section: 0)) as? CollectionViewMovie else { return UICollectionViewCell() }
            collectionCell.loadData(movies: recommendsMovies)
            collectionCell.onSelect = { [unowned self] rail, asset in
                self.openDetails(for: asset, with: rail, using: viewController)
            }
            return collectionCell
        default:
            return UICollectionViewCell()
        }

        
    }

}
