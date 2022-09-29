//
//  DetailViewController.swift
//  BAZProjectC1
//
//  Created by efloresco on 21/09/22.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var imgDetail: UIImageView!
    var objMov: MovieUpdate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadImage()
        
    }
    
    private func configureViewController() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    private func loadImage() {
        if let urlImage = objMov?.imageDetail {
            imgDetail.loadFrom(strUrl: "\(urlImage)")
        } else {
            imgDetail.image = UIImage.init(named: "placeHolder")
        }
    }
    
}
