//
//  ImageAPI.swift
//  BAZProjectC1
//
//  Created by 1030361 on 04/10/22.
//

import UIKit

internal final class ImageAPI: APIURLHandler {
    override init(url: String) {
        super.init(url: url)
    }
    
    func retreiveImageFromSource() -> UIImage {
        let uiImage = UIImage(data: self.getDataFromURL() ?? Data()) ?? UIImage()
        return uiImage
    }
}
