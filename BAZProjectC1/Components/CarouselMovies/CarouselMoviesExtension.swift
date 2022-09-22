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
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
