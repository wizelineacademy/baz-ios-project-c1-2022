//  RateViewController.swift
//  BAZProjectC1
//  Created by 291732 on 07/10/22.

import UIKit

protocol RateVCDelegate: AnyObject {
    func updateRank(withValue newVal: String)
}

class RateViewController: UIViewController {
    //MARK: - O U T L E T S
    @IBOutlet weak var vwContainer: UIView!
    
    weak var delegate: RateVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRateView()
    }
    
    func setRateView(){
        let rateView = RateView.instantiate()
        rateView.delegate = self
        vwContainer.addSubview(rateView)
    }
    
}

//MARK: - EXT -> R A T E · 
extension RateViewController: RateViewDelegate {
    
    func rateMovie(withValue strVal: String) {        delegate?.updateRank(withValue: strVal)
        self.dismiss(animated: true, completion: nil)
    }
    
    func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
}
