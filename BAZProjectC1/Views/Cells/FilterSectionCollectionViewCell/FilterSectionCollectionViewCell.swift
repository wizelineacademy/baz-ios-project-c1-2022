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
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        contentFilter.roundCornersView(radious: 15.00)
    }

    func disableState() {
        contentFilter.setBorder(color: UIColor(named: "aux100Color") ?? .clear)
        titleFilter.textColor = UIColor(named: "aux100Color")
        contentFilter.backgroundColor = UIColor(named: "AccentColor")
    }

    func enableState() {
        contentFilter.backgroundColor = UIColor(named: "aux100Color")
        contentFilter.setBorder(color: UIColor(named: "aux100Color") ?? .clear)
        titleFilter.textColor = UIColor(named: "AccentColor")
    }
}
