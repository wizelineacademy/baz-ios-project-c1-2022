//
//  DetailsMovieCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1029186 on 01/10/22.
//

import UIKit

class DetailsMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        posterImageView.layer.cornerRadius = 10.00
    }
}
