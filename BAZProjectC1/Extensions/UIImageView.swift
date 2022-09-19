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
                if let _ = error {
                    self.image = UIImage(named: "default")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    self.image = image
                }else{
                    self.image = UIImage(named: "default")
                }
            }
        }).resume()
    }
}
