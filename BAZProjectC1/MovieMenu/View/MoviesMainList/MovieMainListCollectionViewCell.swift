//
//  MovieMainListCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1030361 on 22/09/22.
//

import UIKit

class MovieMainListCollectionViewCell: UICollectionViewCell {

    static var identifier = "MovieMainListCollectionViewCell"
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLabel(text: String) {
        lblName.text = text
        lblName.adjustsFontSizeToFitWidth = true
        lblName.minimumScaleFactor = 0.5
    }
    
    func setImage(img: UIImage) {
        imageView.image = img.resized(to: CGSize(width: 100.0, height: 200.0))
    }

}
