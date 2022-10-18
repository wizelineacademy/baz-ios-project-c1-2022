//
//  ReviewsCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 16/10/22.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configReviews(reviews: Reviews){
        lblName.text = reviews.author
        lblReview.text = reviews.content
        if let rating = reviews.author_details.rating {
            lblRating.text = "\(Int(rating))"
        }
        
    }
}
