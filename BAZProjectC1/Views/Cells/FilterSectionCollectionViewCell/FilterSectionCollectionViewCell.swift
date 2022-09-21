//
//  FilterSectionCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by 1029186 on 21/09/22.
//

import UIKit

class FilterSectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentFilter: UIView!
    @IBOutlet weak var titleFilter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentFilter.roundCornersView(radious: 15.00)
    }

    func disableState() {
        contentFilter.setBorder(color: .black)
        titleFilter.textColor = .black
        contentFilter.backgroundColor = .white
    }

    func enableState() {
        contentFilter.backgroundColor = .darkGray
        contentFilter.setBorder(color: .darkGray)
        titleFilter.textColor = .white
    }
}
