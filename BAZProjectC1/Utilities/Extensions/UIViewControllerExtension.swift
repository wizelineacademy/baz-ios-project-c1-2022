//
//  UIViewControllerExtension.swift
//  BAZProjectC1
//
//  Created by 961184 on 01/10/22.
//

import UIKit

extension UIViewController{
    
    /**
     A function that allows you to add a gesture to the main view of the UIViewController to hide keyboard.
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /**
     A function that hides the keyboard
     */
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
