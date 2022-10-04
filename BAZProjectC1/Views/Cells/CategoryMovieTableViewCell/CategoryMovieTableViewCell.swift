//
//  CategoryMovieTableViewCell.swift
//  BAZProjectC1
//
//  Created by 1029186 on 27/09/22.
//

import UIKit

class CategoryMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet private weak var contentMovie: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentMovie.roundCornersView(radious: 15.00)
        posterMovie.layer.cornerRadius = 15.00
        posterMovie.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setValuesMovie(posterImage: UIImage?, titleMovie: String?) {
        posterMovie.image = posterImage ?? UIImage(systemName: "poster")
        titleMovieLabel.text = titleMovie ?? "Without title 🥲"
    }
}
