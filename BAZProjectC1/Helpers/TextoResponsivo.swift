//
//  TextoResponsivo.swift
//  BAZProjectC1
//
//  Created by Fernando Garcia Hernandez on 14/10/22.
//

import Foundation
import UIKit

protocol TextoResponsivoProtocol {
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?)
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]?)
}

extension TextoResponsivoProtocol {
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
        post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}

class TextoResponsivo {
    var myNotificationCenter: TextoResponsivoProtocol
    
    init(notificationCenter: TextoResponsivoProtocol = MyNotificationCenter()) {
        self.myNotificationCenter = notificationCenter
    }
    
    func subscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: object)
    }
}

class MyNotificationCenter: NotificationCenter, TextoResponsivoProtocol {
    override func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]?) {
        super.post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}

