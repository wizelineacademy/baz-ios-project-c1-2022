//
//  movieCarouselCell.swift
//  BAZProjectC1
//
//  Created by 1044336 on 22/09/22.
//

import UIKit

class movieCarouselCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: movieCarouselCell.self)
    
    required init?(coder: NSCoder) {    fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect){
        super.init(frame: frame)
        setupUI()
    }
    func setupUI(){
        backgroundColor = UIColor.green
    }
    func configuration(dataInfo: MovieModel){
        print(dataInfo)
    }
}
