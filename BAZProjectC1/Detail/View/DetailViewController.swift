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
    var objMov: Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if let str = objMov?.poster_path {
            imgDetail.loadFrom(strUrl: "\(strPathImage)\(str)")
        }
    }
}
