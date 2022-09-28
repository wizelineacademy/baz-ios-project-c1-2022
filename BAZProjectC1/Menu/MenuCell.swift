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
        lblDetail.text = rowMenu.detail
        imgDetail.image = UIImage.init(named: rowMenu.image)
    }
    
    func configureCellWithUrl(movieInfo: Movie) {
        lblTitle.text = movieInfo.title
        lblDetail.text = movieInfo.descriptionMovie
        imgDetail.loadFrom(strUrl: "\(tmdbImageStringURLPrefix)\(movieInfo.posterPath)")
    }
    
}
