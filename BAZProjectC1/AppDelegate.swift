//
//  AppDelegate.swift
//  BAZProjectC1
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    @objc private func didLanguageResponseChange(_ notification: Notification) {
        guard
            let info = notification.userInfo as? [String: ApiLanguageResponse],
            let languageResponse = info["languageResponse"],
            let encoded = try? JSONEncoder().encode(languageResponse) else { return }
        UserDefaults.standard.set(encoded, forKey: "SelectedLanguageResponse")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NotificationCenter.default.addObserver(self, selector: #selector(didLanguageResponseChange(_:)), name: .didLanguageResponseChange, object: nil)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: .didLanguageResponseChange, object: nil)
    }


}

extension NSNotification.Name {
    static var didLanguageResponseChange = NSNotification.Name("didLanguageResponseChange")
}
