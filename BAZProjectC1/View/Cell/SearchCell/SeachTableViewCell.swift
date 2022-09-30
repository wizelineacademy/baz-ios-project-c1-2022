//  SeachTableViewCell.swift
//  BAZProjectC1
//  Created by 291732 on 28/09/22.

import UIKit

final class SeachTableViewCell: UITableViewCell {
    //MARK: - O U T L E T S
    @IBOutlet private weak var vwContainer: UIView!
    @IBOutlet private weak var cvCollectionContainer: UICollectionView!{
        didSet{
            self.cvCollectionContainer.delegate = self
            self.cvCollectionContainer.dataSource = self
            self.cvCollectionContainer.register(UINib(nibName: "ElementCollectionViewCell",
                                                       bundle: .main),
                                                 forCellWithReuseIdentifier: ElementCollectionViewCell.identifier)
        }
    }
    
    //MARK: -  V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main ) }
    


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(){
        
    }
    
}

extension SeachTableViewCell: UICollectionViewDelegate & UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementCollectionViewCell.identifier, for: indexPath) as? ElementCollectionViewCell ?? ElementCollectionViewCell()
        return cCell
    }

}
