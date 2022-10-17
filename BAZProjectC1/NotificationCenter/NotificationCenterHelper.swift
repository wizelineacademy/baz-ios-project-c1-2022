//
//  NotificationCenter.swift
//  BAZProjectC1
//
//  Created by Carlos Nitsuga Hernandez on 13/10/22.
//

import Foundation

final class NotificationCenterHelper: NotificationCenter {
    
    //MARK: - Properties
    static let myNotificationCenter: NotificationCenter = NotificationCenter()
    
    //MARK: - Methods
    static func suscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        NotificationCenterHelper.myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: object)
    }
    
    func unsubscribeNotification(_ unsubscriber: AnyObject, name: NSNotification.Name, object: Any? = nil) {
        self.removeObserver(unsubscriber)
    }
}

//MARK: - Notificaction Name
extension Notification.Name {
    static let detailMovie = Notification.Name(
        rawValue: "detailMovie")
}
