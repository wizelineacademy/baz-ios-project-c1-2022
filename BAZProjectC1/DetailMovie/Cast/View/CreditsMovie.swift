//
//  CreditsMovie.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 01/10/22.
//

import UIKit

final class CreditsMovie: UICollectionViewCell {
    
    //MARK: - Properties
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    //MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    /** Function that configure the view*/
    private func configView() {
        mainView.layer.cornerRadius = 10
        actorImage.layer.cornerRadius = 10
    }
}
