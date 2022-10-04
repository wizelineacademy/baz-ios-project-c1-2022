//
//  DetailsMovieCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1029186 on 01/10/22.
//

import UIKit

class DetailsMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        posterImageView.layer.cornerRadius = 10.00
    }

    func setupCollectionCell(image: UIImage?, description: String) {
        if let image = image {
            posterImageView.image = image
        }
        titleLabel.text = description
    }
}
