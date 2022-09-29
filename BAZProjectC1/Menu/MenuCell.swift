//
//  MenuCell.swift
//  BAZProjectC1
//
//  Created by efloresco on 20/09/22.
//

import UIKit

enum ElectionDate: String {
    case title = "title"
    case detail = "detail"
    case image = "image"
}

class MenuCell: UITableViewCell {

    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellMenu(with rowMenu: MenuRow) {
        lblTitle.text = rowMenu.title
        lblTitle.font = UIFont(name: "Marker Felt", size: 16)
        lblDetail.text = rowMenu.detail
        lblDetail.font = UIFont(name: "Marker Felt", size: 14)
        imgDetail.image = UIImage.init(named: rowMenu.image)
    }
    
    func configureCellWithUrl(movieInfo: MovieUpdate) {
        lblTitle.text = movieInfo.title
        lblTitle.font = UIFont(name: "Marker Felt", size: 16)
        lblDetail.text = movieInfo.overview
        lblDetail.font = UIFont(name: "Marker Felt", size: 14)
        imgDetail.loadFrom(strUrl: "\(movieInfo.imageDetail)")
    }
    
}
