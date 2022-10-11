//
//  FilterTypeMovieCollectionViewCell.swift
//  BAZProjectC1
//
//  Created by Jacobo Diaz on 02/10/22.
//

import UIKit

class FilterTypeMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitleTypeMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                lblTitleTypeMovie.alpha = 1
            }else{
                lblTitleTypeMovie.alpha = 0.5
                
            }
        }
    }
    
}
