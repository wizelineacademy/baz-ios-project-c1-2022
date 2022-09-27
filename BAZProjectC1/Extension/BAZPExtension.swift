//  BAZPExtension.swift
//  BAZProjectC1
//  Created by 291732 on 19/09/22.

import UIKit
import Foundation

//MARK: - UI · T A B L E · V I E W · C E L L
extension UITableViewCell {
    ///Identifier nos ayudará a poder saber la identidad de nuestra celda, y usarla en cualquiera que herede de UITableViewCell
    class var identifier: String { return String(describing: self)}
}

//MARK: - UI · V I E W
extension UIView {
    /// Esta variable nos ayudara a configurar el radio de una vista, desde codigo o desde el Custom Class de Xcode
    /// -  get: Regresa el valor del radio en CGFloat
    /// -  set: Obitiene un nuevo valor de tipo CGFloat para configurar el radio de las esquinas
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    /// Esta variable nos ayudara a configurar el radio de una vista, desde codigo o desde el Custom Class de Xcode
    /// -  get: Regresa el valor del borde en CGFloat
    /// -  set: Obtiene un nuevo valor de tipo CGFloat para configurar el borde
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    func applyGradient(isVertical: Bool, colorArray: [UIColor]) {
        layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
         
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorArray.map({ $0.cgColor })
        if isVertical {
            //top to bottom
            gradientLayer.locations = [0.0, 1.0]
        } else {
            //left to right
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        
        backgroundColor = .clear
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addGradientWithColor(color: UIColor) {
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = [UIColor.clear.cgColor, color.cgColor]

            self.layer.insertSublayer(gradient, at: 0)
        }
}

//MARK: - UI · I M A G E · V I E W
extension UIImageView {
    /// Esta función permite la descarga de una imagen y colocarla en un UIImageView
    /// - Parameter url: Recibe una URL de donde va a tomar el recurso
    /// - Returns: una imagen descargada de internet
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){[weak self] url, response, error in
            guard let self = self else { return }
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}

