//
//  Extensions.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 22/09/22.
//

import Foundation
import UIKit

// Mark: - For download image
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit){
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {return}
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
}

extension UIImage {
      convenience init?(url: URL?) {
        guard let url = url else { return nil }
                
        do {
          self.init(data: try Data(contentsOf: url))
        } catch {
            debugPrint("Cannot load image from url: \(url) with error: \(error)")
          return nil
        }
      }
}


// Mark: - Custom UIActivityIndicatorView

extension UIView{

    func showAnimation() {
        let container = UIView()
        container.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        container.backgroundColor  = UIColor(white: 0.55, alpha: 0.5)
        container.tag = 475647
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = container.center
        loadingView.backgroundColor = .darkGray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)

        self.addSubview(container)
    }

    func hideAnimation() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
}
