//  ReviewTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 04/10/22.

import UIKit

final class ReviewTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet private weak var vwContainer: UIView!{
        didSet{
            self.vwContainer.layer.borderWidth = 1
            self.vwContainer.layer.borderColor = .init(red: 117/255, green: 31/255, blue: 34/255, alpha: 1)
        }
    }
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblConten: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    private var downloadTask: URLSessionDownloadTask?

    
    //MARK: - F U N C T I O N S
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setReview(with review: Review){
        self.lblUser.text = "\(review.author ?? "") Says:"
        self.lblConten.text = review.content
        self.lblDate.text = review.createdAt
    }

}
