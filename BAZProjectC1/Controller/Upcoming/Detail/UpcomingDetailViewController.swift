//  UpcomingDetailViewController.swift
//  BAZProjectC1
//  Created by 291732 on 23/09/22.

import UIKit

class UpcomingDetailViewController: UIViewController {
    
    @IBOutlet weak var lblUTitle: UILabel!
    @IBOutlet weak var imgUMovie: UIImageView!
    @IBOutlet weak var lblUOverview: UILabel!
    @IBOutlet weak var lblUVote: UILabel!
    @IBOutlet weak var lblUYear: UILabel!
    
    
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
