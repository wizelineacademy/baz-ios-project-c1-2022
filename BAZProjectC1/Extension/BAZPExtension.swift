//  BAZPExtension.swift
//  BAZProjectC1
//  Created by 291732 on 19/09/22.

import UIKit
import Foundation

//MARK: - UI · T A B L E · V I E W · C E L L
public extension UITableViewCell {
    class var identifier: String { return String(describing: self)}
}

//MARK: - UI · V I E W
public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
}

//MARK: - UI · I M A G E · V I E W
extension UIImageView{
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
