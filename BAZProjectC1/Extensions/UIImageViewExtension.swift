//
//  UIImageViewExtension.swift
//  BAZProjectC1
//
//  Created by 1044336 on 17/09/22.
//

import Foundation
import UIKit
extension UIImageView{
    public func loadImageFromUrl(urlString: String){
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url){
                    if let image = UIImage(data: data){
                        DispatchQueue.main.async {  self?.image = image     }
                    }
                }
            }
        }
    }
}

