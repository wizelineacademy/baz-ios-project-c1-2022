//  RateView.swift
//  BAZProjectC1
//  Created by 291732 on 07/10/22.

import UIKit

//MARK: - P R O T O C O L S
protocol RateViewDelegate : AnyObject {
    func closeView()
    func rateMovie(withValue strVal: String)
}

class RateView: UIView {
    //MARK: - O U T L E T S
    @IBOutlet weak var txfRank: UITextField!
    @IBOutlet weak var btnRank: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    //MARK: - V A R I A B L E S
    static var nib: UINib { return UINib(nibName: identifier, bundle: .main)}
    static var identifier: String { return String(describing: self) }
    weak var delegate: RateViewDelegate?
    
    override func awakeFromNib() { }
    
    //MARK: - A C T I O N S · D E L E G A T E S
    @IBAction func closeView() {
        delegate?.closeView()
    }
    
    @IBAction func rateMovie() {
        delegate?.rateMovie(withValue: txfRank.text ?? "0.0")
    }
    
    public class func instantiate() -> RateView {
        if let nib = Bundle.main.loadNibNamed(RateView.identifier, owner: self, options: nil)?[0] as? RateView{
            return nib
        }
        return RateView()
    }

}
