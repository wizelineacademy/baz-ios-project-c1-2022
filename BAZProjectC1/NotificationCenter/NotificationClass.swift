//
//  NotificationClass.swift
//  BAZProjectC1
//
//  Created by efloresco on 30/09/22.
//

import Foundation

class NotificationClass {
    static var myNotificationCenter : NotificationCenter = NotificationCenter()
    
    static func suscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        NotificationClass.myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: object)
    }
    
}

class MyNotificationCenter: NotificationCenter { }
