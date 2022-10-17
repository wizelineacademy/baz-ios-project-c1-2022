//
//  CollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 27/09/22.
//

import UIKit

final class CollectionViewMovie: UICollectionViewCell {
    
    //MARK: - Properties
    @IBOutlet private weak var collectionView: UICollectionView!
    private let cellIdentifier = "MovieCardCell"
    private var movies = Movie(results: [MovieData]())
    typealias cellSelectionClosure = ((Movie,MovieData) -> Void)
    public var onSelect: cellSelectionClosure?
    private let numberOfSections = 5
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    /**  Function that configure the view */
    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    /**
     Function that load the movies
     - Parameters:
     - movies: object of Movie
     */
    public func loadData(movies: Movie) {
        self.movies = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView's Data Source
extension CollectionViewMovie: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCardCellController else { return UICollectionViewCell() }
        cell.movieTitle.text = movies.results[indexPath.row].title
        if let imageMovie = movies.results[indexPath.row].posterPath {
            cell.movieImage.downloaded(from: "\(imageMovie)")
            cell.movieVotes.text = "\(String(Int(movies.results[indexPath.row].voteAverage!.rounded(.down))))/10"
        }
        return cell
    }
}

// MARK: - CollectionView's Delegate
extension CollectionViewMovie: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(movies, movies.results[indexPath.item])
    }
}

// MARK: - CollectionView's Flow Layout
extension CollectionViewMovie: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(150), height: CGFloat(300))
    }
}

