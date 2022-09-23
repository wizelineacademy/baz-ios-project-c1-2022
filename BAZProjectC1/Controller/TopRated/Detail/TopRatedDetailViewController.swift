//
//  TopRatedDetailViewController.swift
//  BAZProjectC1
//
//  Created by 291732 on 23/09/22.
//

import UIKit

class TopRatedDetailViewController: UIViewController {
    
    @IBOutlet weak var lblTTitle: UILabel!
    @IBOutlet weak var imgTMovie: UIImageView!
    @IBOutlet weak var lblTOverview: UILabel!
    @IBOutlet weak var lblTVote: UILabel!
    @IBOutlet weak var lblTYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func setUpLeftMenu() {
        let menuBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                            style: .plain, target: self, action:  #selector(popView))
        navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc private func popView(){
        navigationController?.popViewController(animated: true)
    }

    
}
