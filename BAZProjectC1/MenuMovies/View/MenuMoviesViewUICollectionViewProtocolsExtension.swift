//
//  MenuMoviesViewUICollectionViewProtocolsExtension.swift
//  BAZProjectC1
//
//  Created by 961184 on 01/10/22.
//

import UIKit

// MARK: - UICollectionViewDataSource
extension MenuMoviesView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? presenter?.getSearchedMovieCount() ?? 0: presenter?.getMovieCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieItemCollectionViewCell", for: indexPath) as? MovieItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = self.isSearching ? self.presenter?.getSearchedMovie(indexPathRow: indexPath.row) : self.presenter?.getMovie(indexPathRow: indexPath.row)
        cell.requiredSetupUI(movie: movie)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = self.isSearching ? self.presenter?.getSearchedMovie(indexPathRow: indexPath.row) : self.presenter?.getMovie(indexPathRow: indexPath.row)
        self.title = ""
        self.view.addSkeletonAnimation()
        presenter?.getMovieDetail(idMovie: selectedMovie?.id ?? 0)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MenuMoviesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginAndInsets : CGFloat
        marginAndInsets = minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + insets * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth + heightAditionalConstant)
    }
}

