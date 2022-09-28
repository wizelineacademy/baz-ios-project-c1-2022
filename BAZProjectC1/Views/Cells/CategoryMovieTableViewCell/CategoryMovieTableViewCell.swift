//
//  CategoryMovieTableViewCell.swift
//  BAZProjectC1
//
//  Created by 1029186 on 22/09/22.
//

import UIKit

class CategoryMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
