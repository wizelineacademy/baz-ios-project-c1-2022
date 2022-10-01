//
//  CollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 27/09/22.
//

import UIKit

class CollectionViewMovie: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellIdentifier = "MovieCardCell"
    private var movies = Movie(results: [MovieData]())
    typealias cellSelectionClosure = ((Movie,MovieData) -> Void)
    public var onSelect: cellSelectionClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    public func loadData(movies: Movie) {
        self.movies = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionViewMovie: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.results.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCardCellController else { return UICollectionViewCell() }
        cell.movieTitle.text = movies.results[indexPath.row].title
        cell.movieImage.downloaded(from: "https://image.tmdb.org/t/p/w500\(movies.results[indexPath.row].posterPath)")
        cell.movieVotes.text = String(movies.results[indexPath.row].voteCount)
        return cell
    }
}

extension CollectionViewMovie: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(movies, movies.results[indexPath.item])
    }
}

extension CollectionViewMovie: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: CGFloat(150), height: CGFloat(300))
    }
}

