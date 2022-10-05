//
//  CarouselMenuExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import Foundation
import UIKit

fileprivate let paddingScreenPixel: CGFloat = 16
fileprivate let fontPointSizePixel: Int = 8
fileprivate let arrayHelperSize: Int = 1

extension CarouselMenu: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setOptionSelected(row: indexPath.row)
        delegate?.carouselMenu(self, didSelectOption: indexPath)
    }
}
extension CarouselMenu: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OptionMenuCell.reuseIdentifier), for: indexPath) as? OptionMenuCell else {  return UICollectionViewCell() }
        
        let setupModel: OptionMenuCellConfiguration
        if optionSelected ==  indexPath.row {
            setupModel = OptionMenuCellConfiguration(itemBackgroundColor: itemBackgroundColor, itemBorderBackgroundColor: itemBorderBackgroundColor, titleText: "\(menuOptions[indexPath.row])")
        } else {
            setupModel = OptionMenuCellConfiguration(itemBackgroundColor: itemSelectedBackgroundColor, itemBorderBackgroundColor: itemSelectedBorderBackgroundColor, titleText: "\(menuOptions[indexPath.row])")
        }
        cell.setUpView(with: setupModel)
        return cell
    }
}
extension CarouselMenu: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = CGFloat((menuOptions[indexPath.row].lengthOfBytes(using: .utf8) + arrayHelperSize) * fontPointSizePixel) + paddingScreenPixel
        return CGSize(width: newWidth, height: collectionView.frame.height)
    }
}
