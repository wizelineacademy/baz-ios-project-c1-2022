//
//  CarosuelMenuExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import Foundation
import UIKit

fileprivate let PADDING_SCREEN_PIXEL: CGFloat = 16
fileprivate let FONT_PONTSIZE_PIXEL: Int = 8
fileprivate let ARRAY_HELPER_SIZE: Int = 1

extension CarosuelMenu:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        optionSelected = indexPath.row
        delegate?.selectedOption(index: indexPath)
    }
}
extension CarosuelMenu: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: optionMenuCell.reuseIdentifier), for: indexPath) as? optionMenuCell else {  return UICollectionViewCell() }
        
        let setupModel: OptionMenuCellConfiguration
        if optionSelected ==  indexPath.row {
            setupModel = OptionMenuCellConfiguration(itemBackgroundColor: itemBackgroundColor,
                                                         itemBorderBackgroundColor: itemBorderBackgroundColor,
                                                         titleText: "\(menuOptions[indexPath.row])")
        }
        else{
            setupModel = OptionMenuCellConfiguration(itemBackgroundColor: itemSelectedBackgroundColor,
                           itemBorderBackgroundColor: itemSelectedBorderBackgroundColor,
                           titleText: "\(menuOptions[indexPath.row])")
        }
        cell.setUpView(with: setupModel )
        return cell
    }
}
extension CarosuelMenu:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = CGFloat((menuOptions[indexPath.row].lengthOfBytes(using: .utf8) + ARRAY_HELPER_SIZE) * FONT_PONTSIZE_PIXEL) + PADDING_SCREEN_PIXEL
        return CGSize(width: newWidth, height: collectionView.frame.height)
    }
}
