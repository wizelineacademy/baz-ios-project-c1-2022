//
//  UIImageViewExtension.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 23/09/22.
//

import UIKit

extension UIImageView {
    
    /**
     Function that downloads and displays the image
     - Parameters:
     - url: url where the image is obtained
     - contentMode:type of content mode
     */
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with:url) { data,response,error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage (data: data)
            else { return }
            DispatchQueue.main.async() { [weak self]in
                self?.image = image
                
            }
        }.resume ()
    }
    
    /**
     Function that downloads and displays the image
     - Parameters:
     - link: url of type string where the image is obtained
     - contentMode:type of content mode
     */
    func downloaded (from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded (from: url, contentMode: mode)
    }
}
