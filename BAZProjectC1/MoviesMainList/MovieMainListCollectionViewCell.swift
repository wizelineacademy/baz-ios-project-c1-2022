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
        lblName.text = "1"
    }
    
    func setLabel(text: String) {
        
        lblName.text = text
    }
    
    func setImage(img: String) {
        
    }

}
