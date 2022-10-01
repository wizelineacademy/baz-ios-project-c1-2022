//
//  PopularViewController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 21/09/22.
//

import Foundation
import UIKit

final class HomeMoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    private var numberOfSections:Int = 5
    
    private var presenter: MoviePresenter?
    
    var asset: [MovieData]!
    var rail: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()
        presenter = MoviePresenter(view: self)
        presenter?.loadMovies(using: collectionView)
    }
    
    /** Function that configures the collection view */
    private func configCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewMovie", bundle: nil), forCellWithReuseIdentifier: "CollectionViewMovie")
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
    }
    
    func presentView(for information: MovieData) {
        guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieInformationController else { return }
        vcMovieDetails.movies = information
        //self.present(vcMovieDetails, animated: true, completion: nil)
        self.navigationController?.pushViewController(vcMovieDetails, animated: true)
    }
}

// MARK: - CollectionView's DataSource
extension HomeMoviesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return presenter!.getMovies(forRow: indexPath.section, using: collectionView, forPresent: self)
   
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderViewController
        switch indexPath.section {
        case 0:
            header?.titleLabel.text = "Trending"
        case 1:
            header?.titleLabel.text = "Now playing"
        case 2:
            header?.titleLabel.text = "Popular"
        case 3:
            header?.titleLabel.text = "Top Rated"
        case 4:
            header?.titleLabel.text = "Upcoming"
        default:
            return UICollectionReusableView()
        }
        return header!
    }
}

extension HomeMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: CGFloat(300))
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: CGFloat(100))
    }
}      


