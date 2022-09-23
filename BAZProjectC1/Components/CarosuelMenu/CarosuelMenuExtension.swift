//
//  CarosuelMenuExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import Foundation
import UIKit

extension CarosuelMenu:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        optionSelected = indexPath.row
        delegate?.selectedOption(index: indexPath)
    }
}
extension CarosuelMenu: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: optionMenuCell.reuseIdentifier), for: indexPath) as? optionMenuCell else {  return UICollectionViewCell() }
        if optionSelected ==  indexPath.row {
            cell.setUpView(itemBackgroundColor: itemBackgroundColor,
                           itemBorderBackgroundColor: itemBorderBackgroundColor,
                           titleText: "\(menuOptions[indexPath.row])")
        }
        else{
            cell.setUpView(itemBackgroundColor: itemSelectedBackgroundColor,
                           itemBorderBackgroundColor: itemSelectedBorderBackgroundColor,
                           titleText: "\(menuOptions[indexPath.row])")
        }
        return cell
    }
}
extension CarosuelMenu:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = CGFloat((menuOptions[indexPath.row].lengthOfBytes(using: .utf8) + 1) * 8) + 16
        return CGSize(width: newWidth, height: collectionView.frame.height)
    }
}
