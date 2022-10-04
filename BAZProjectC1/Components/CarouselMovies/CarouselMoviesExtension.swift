//
//  CarouselMoviesExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 21/09/22.
//

import Foundation
import UIKit

fileprivate let TOTAL_PADDING_SCREEN_PIXEL: CGFloat = 32
fileprivate let SCREEN_PERCENTAGE_PIXEL: CGFloat = 0.66

extension CarouselMovies: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.movieSelected(position: indexPath.row)
    }
}
extension CarouselMovies: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if typeCarousel == "MovieModel" {
            return infoCarousel.count
        } else {
            return infoCarouselCast .count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCarouselCell.reuseIdentifier), for: indexPath) as? MovieCarouselCell else {  return UICollectionViewCell() }
        if typeCarousel == "MovieModel" {
            let movie = infoCarousel[indexPath.row]
            cell.configuration(dataInfo: movie)
        } else {
            let cast = infoCarouselCast[indexPath.row]
            cell.configuration(dataInfo: cast)
        }
        
        
        return cell
    }
}
extension CarouselMovies: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - TOTAL_PADDING_SCREEN_PIXEL) * SCREEN_PERCENTAGE_PIXEL, height: collectionView.frame.height - TOTAL_PADDING_SCREEN_PIXEL)
    }
}


