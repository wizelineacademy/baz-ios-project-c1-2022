//
//  UIImageView.swift
//  BAZProjectC1
//
//  Created by 1054812 on 15/09/22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    /// Método utilizado para el consumo de imágenes
    ///  - Parameters:
    ///     - urlString: Contiene el endpoint de la imagen a descargar
    /// - En el método se valida si la imagen ya fue descargada previamente y de ser así se toma de caché, en caso contrario se procede a descargar.
    public func loadUrlImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.image = UIImage(named: "default")
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
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
