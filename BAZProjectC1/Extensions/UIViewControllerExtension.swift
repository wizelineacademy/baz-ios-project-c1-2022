//
//  UIViewControllerExtension.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 04/10/22.
//

import UIKit

extension UIViewController {
    //MARK: - Methods
    
    /**  Function that hide keyboard when tapped aroundr */
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /**  Function that dismiss the keyboard */
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
