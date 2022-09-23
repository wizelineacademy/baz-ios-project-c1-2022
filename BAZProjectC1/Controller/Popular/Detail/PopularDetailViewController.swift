//
//  PopularDetailViewController.swift
//  BAZProjectC1
//
//  Created by 291732 on 23/09/22.
//

import UIKit

class PopularDetailViewController: UIViewController {
    
    @IBOutlet weak var lblPlTitle: UILabel!
    @IBOutlet weak var imgPlMovie: UIImageView!
    @IBOutlet weak var lblPlOverview: UILabel!
    @IBOutlet weak var lblPlVote: UILabel!
    @IBOutlet weak var lbllPYear: UILabel!
    
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
