//
//  CollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    func setImage(urlEndpoint: String){
        let urlImage = "https://image.tmdb.org/t/p/w500\(urlEndpoint)"
        if let url = URL(string: urlImage) {
            self.posterImage.downloaded(from: url)
        } else {
            let bundle = Bundle(for: TableViewCell.self)
            if let image = UIImage(named: "poster", in: bundle, compatibleWith: nil){
                self.posterImage.image = image
            }
        }
        
    }

}
