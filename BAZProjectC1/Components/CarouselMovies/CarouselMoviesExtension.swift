//
//  CarouselMoviesExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import Foundation
import UIKit
extension CarouselMovies: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieSelected(position: indexPath.row)
    }
}
extension CarouselMovies: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return infoCarousel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: movieCarouselCell.reuseIdentifier), for: indexPath) as? movieCarouselCell else {  return UICollectionViewCell() }
        let movie = infoCarousel[indexPath.row]
        cell.configuration(dataInfo: movie)
        return cell
        
    }
}
extension CarouselMovies: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width - 32) * 0.66, height: collectionView.frame.height - 32)
    }
}


