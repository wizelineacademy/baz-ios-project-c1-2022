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
    private let urlBaseImage: EndPoint = .imageFromURL
    
    /// This function set a image from URL
    /// - Parameters:
    ///   - urlEndpoint: is an URL string of a valid image
    func setImage(urlEndpoint: String){
        self.posterImage.downloaded(imagePath: "\(urlBaseImage.requestFrom)\(urlEndpoint)")
    }

}
