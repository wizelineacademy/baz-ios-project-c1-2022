//
//  PopularViewController.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 21/09/22.
//

import Foundation
import UIKit

enum SectionTitles: String {
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top  Rated"
    case upcoming = "Upcoming"
}

final class HomeMoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var numberOfSections: Int = 5
    private var presenter: MoviePresenter?
    private let headerReuseIndentifier = "HeaderView"
    private let collectionMovieReuseIdentifier = "CollectionViewMovie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollection()
    }
    
    /** Function that configures the collection view */
    private func configCollection() {
        presenter = MoviePresenter(view: self)
        presenter?.loadMovies(using: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: collectionMovieReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionMovieReuseIdentifier)
        collectionView.register(UINib(nibName: headerReuseIndentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIndentifier)
    }
    
    public func presentView(for information: MovieData) {
        guard let vcMovieDetails =  self.storyboard?.instantiateViewController(withIdentifier: "infoview") as? MovieDetailController else { return }
        vcMovieDetails.movies = information
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
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderViewController else { return UICollectionReusableView() }
        switch indexPath.section {
        case 0:
            header.titleLabel.text = SectionTitles.trending.rawValue
        case 1:
            header.titleLabel.text = SectionTitles.nowPlaying.rawValue
        case 2:
            header.titleLabel.text = SectionTitles.popular.rawValue
        case 3:
            header.titleLabel.text = SectionTitles.topRated.rawValue
        case 4:
            header.titleLabel.text = SectionTitles.upcoming.rawValue
        default:
            return UICollectionReusableView()
        }
        return header
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


