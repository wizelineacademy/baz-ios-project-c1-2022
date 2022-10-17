//
//  DetailPresenter.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import UIKit

final class CastPresenter {
   
    //MARK: - Properties
    private var recommends:MovieListProtocol = MovieList()
    private var actorsMovie:MovieCastProtocol = MovieCastState()
    private var recommendsMovies = Movie(results: [MovieData]())
    private var castMovie = MovieCast(cast: [Cast]())
    private let reuseIndentifier = "CollectionViewCast"
    private weak var view: MovieDetailController?
    
    //MARK: - Methods
    init(view: MovieDetailController) {
        self.view = view
    }
    
    public func loadCast(using collectionView: UICollectionView, movieId: Int)  {
            actorsMovie.loadMoviesCast(completion: { (cast) in
                self.castMovie = cast
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }, movieId)
    }
    
    public func getCast(forRow row: Int, using collectionView: UICollectionView, forPresent viewController: UIViewController) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIndentifier, for: IndexPath(row: row, section: 0)) as? CollectionViewCast else { return UICollectionViewCell() }
        collectionCell.loadData(actorsMovie: castMovie)
        return collectionCell
    }
    
}
