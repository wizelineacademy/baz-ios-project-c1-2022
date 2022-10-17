//
//  MenuCell.swift
//  BAZProjectC1
//
//  Created by efloresco on 20/09/22.
//

import UIKit
 
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
    /**
     - parameters: menu raw model
     * this method loads the movie settings
     * assigns the values ​​to the controls inside the cell
     * view image by url to view
     */
    func configureCellMenu(with rowMenu: MenuRow? = nil) {
        lblTitle.text = rowMenu?.title
        lblTitle.loadConfigurationFont(with: true)
        lblDetail.text = rowMenu?.detail
        lblDetail.loadConfigurationFont(with: false)
        imgDetail.image = UIImage.init(named: rowMenu?.image ?? "")
    }
    
    /**
     - parameters: movieUpdate model
     * this method loads the movie settings
     * assigns the values ​​to the controls inside the cell
     * view image by url to view
     */
    func configureCellWithUrl(movieInfo: MovieUpdate? = nil) {
        lblTitle.text = movieInfo?.title
        lblTitle.loadConfigurationFont(with: true)
        lblDetail.text = movieInfo?.overview
        lblDetail.loadConfigurationFont(with: false)
        imgDetail.loadFrom(strUrl: "\(movieInfo?.imageDetail ?? "")")
    }
    
}
