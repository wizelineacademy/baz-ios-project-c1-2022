//
//  NotificationCenterHelper.swift
//  BAZProjectC1
//
//  Created by 1029186 on 03/10/22.
//

import UIKit

class NotificationCenterHelper: NotificationCenter {

    static let shared: NotificationCenterHelper = NotificationCenterHelper()

    func subscribeNotification(_ subscriber: AnyObject, with selector: Selector, name: NSNotification.Name, object: Any? = nil) {
        self.addObserver(subscriber, selector: selector, name: name, object: object)
    }
}
