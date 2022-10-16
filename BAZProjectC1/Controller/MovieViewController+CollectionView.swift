//
//  MovieViewController+CollectionView.swift
//  BAZProjectC1
//
//  Created by rnunezi on 16/10/22.
//

import UIKit

//MARK: - MovieCollectionViewController + CollectionView

extension MovieCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    //  Method: Set number of sections on the collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ConstantsLayoutMovieCollection.numberOfSections
    }
    
    //  Method: Set number of items in section the collection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMoviesCollection.count
    }
    
    //  Method: Set number of inset for section at  collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: ConstantsLayoutMovieCollection.insets, left: ConstantsLayoutMovieCollection.insets, bottom: ConstantsLayoutMovieCollection.insets, right: ConstantsLayoutMovieCollection.insets)
    }
    
    //  Method: Set minimum Line Spacing For Section at  collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsLayoutMovieCollection.minimumLineSpacing
    }
    
    //  Method: Set minimum Inter item Spacing For Section at  collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ConstantsLayoutMovieCollection.minimumInteritemSpacing
    }
    
    //  Method: Set size for item at  collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let marginAndInsets : CGFloat
        marginAndInsets = ConstantsLayoutMovieCollection.minimumInteritemSpacing * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + ConstantsLayoutMovieCollection.insets * CGFloat(ConstantsLayoutMovieCollection.cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginAndInsets) / CGFloat(ConstantsLayoutMovieCollection.cellsPerRow)).rounded(.down)
        
        return CGSize(width: itemWidth, height: itemWidth + ConstantsLayoutMovieCollection.heightAditionalConstant)
    }
    
    //  Method: Set cell for item at collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setDataMovies(movie: self.arrMoviesCollection[indexPath.row])
        
        return cell
    }
    
    //  Method: Navigation to class detail movie when did select item at  collection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "detailMovie", sender: arrMoviesCollection[indexPath.row])
    }
}
