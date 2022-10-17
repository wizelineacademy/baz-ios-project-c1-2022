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
    /**
     Function that subscribes a notification
     - Parameters:
     - suscriber: the one who subscribes to the notification
     - selector: selector that executes the nofication
     - name: name of the notification
     - object: object that receives the notification
     */
    static func suscribeToNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        NotificationCenterHelper.myNotificationCenter.addObserver(subscriber, selector: selector, name: name, object: object)
    }
    
    /**
     Function that unsubscribes a notification
     - Parameters:
     - unsuscriber: the one who unsubscribes to the notification
     - name: name of the notification
     - object: object that receives the notification
     */
    func unsubscribeNotification(_ unsubscriber: AnyObject, name: NSNotification.Name, object: Any? = nil) {
        self.removeObserver(unsubscriber)
    }
}

//MARK: - Notificaction Name
extension Notification.Name {
    static let detailMovie = Notification.Name(
        rawValue: "detailMovie")
}
