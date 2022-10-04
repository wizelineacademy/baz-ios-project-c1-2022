//
//  NotificationCenterHelper.swift
//  BAZProjectC1
//
//  Created by 1029186 on 03/10/22.
//

import UIKit

class NotificationCenterHelper: NotificationCenter {

    static let shared: NotificationCenterHelper = NotificationCenterHelper()

    /// This method register a new notification center
    /// - Parameters:
    ///   - subscriber: the subscritor
    ///   - selector: the action when the notification received any information
    ///   - name: name of the notification
    ///   - object: the object was send
    func subscribeNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        self.addObserver(subscriber, selector: selector, name: name, object: object)
    }

    /// This method delete a notification center
    /// - Parameter unsubscriber: who want to delete notification
    func unsubscribeNotification(_ unsubscriber: AnyObject) {
        self.removeObserver(unsubscriber)
    }
}
