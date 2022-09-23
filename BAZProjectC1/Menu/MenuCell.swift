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
    
    func configureCell(dctInfo: [String: String]) {
        lblTitle.text = nameOfData(dctInfo: dctInfo, strOption: ElectionDate.title.rawValue)
        lblDetail.text = nameOfData(dctInfo: dctInfo, strOption: ElectionDate.detail.rawValue)
        imgDetail.image = UIImage.init(named: nameOfData(dctInfo: dctInfo, strOption: ElectionDate.image.rawValue))
    }
    
    func configureCellWithUrl(movieInfo: Movie) {
        lblTitle.text = movieInfo.title
        lblDetail.text = movieInfo.descriptionMovie
        imgDetail.loadFrom(strUrl: "\(strPathImage)\(movieInfo.poster_path)")
    }
    
    func nameOfData(dctInfo: [String: String], strOption: String) -> String {
        if let strData = dctInfo[strOption] {
            return strData
        }
        return ""
    }
    
}
