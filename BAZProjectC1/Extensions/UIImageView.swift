//
//  UIImageView.swift
//  BAZProjectC1
//
//  Created by 1054812 on 15/09/22.
//

import UIKit

extension UIImageView {
    func loadUrlImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
    
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          DispatchQueue.main.async {
           if error != nil {
                print(error!)
                let imgDefault = UIImage()
                self.image = imgDefault
                return
            }
                if let image = UIImage(data: data!) {
                    self.image = image
                }else{
                     let imgDefault = UIImage()
                    self.image = imgDefault
                }
            }
        }).resume()
    }
}
