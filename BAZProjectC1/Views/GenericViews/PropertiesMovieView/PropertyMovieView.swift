//
//  ProtertyMovieView.swift
//  BAZProjectC1
//
//  Created by 1029186 on 01/10/22.
//

import UIKit

@IBDesignable
class PropertyMovieView: UIView {

    @IBOutlet private weak var contentPropertyView: UIView!
    @IBOutlet private weak var propertyLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        contentPropertyView.roundCornersView(radious: 10.00)
    }

    /// This func generate a property of the movie with UX design
    /// - Parameter property: the text of property
    func generatePropertyView(_ property: String) {
        let propertyView = UINib(nibName: "PropertyMovieView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        propertyView?.frame = self.bounds
        addSubview(propertyView ?? UIView())
        propertyLabel.text = property
    }
}
