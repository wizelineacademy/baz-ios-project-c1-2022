//
//  MovieInfoCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1030361 on 03/10/22.
//

import UIKit

class MovieInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var moviesArray: [MovieSimilars]?
    var castArray: [Cast]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    func setupCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieMainListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieMainListCollectionViewCell")
    }
}

// MARK: - TrendingViewController's DataSource and Delegate
extension MovieInfoCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if moviesArray ==  nil {
            return castArray?.count ?? 0
        } else {
            return moviesArray?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieMainListCollectionViewCell", for: indexPath) as? MovieMainListCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .blue
        if moviesArray ==  nil {
            cell.setLabel(text: castArray?[indexPath.row].name ?? "")
        } else {
            cell.setLabel(text: moviesArray?[indexPath.row].title ?? "")
        }
        return cell
    }
    
}
