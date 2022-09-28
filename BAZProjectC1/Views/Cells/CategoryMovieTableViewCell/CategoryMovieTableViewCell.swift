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
    @IBOutlet weak var contentMovie: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentMovie.roundCornersView(radious: 15.00)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
