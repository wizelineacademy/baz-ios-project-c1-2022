//
//  AppDelegate.swift
//  BAZProjectC1
//
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var listMoviesNowPlaying: [Movie] = [Movie]()
    var listMoviesTrending: [Movie] = [Movie]()
    var listMoviesPopular: [Movie] = [Movie]()
    var listMoviesTopRated: [Movie] = [Movie]()
    var listMoviesUpcoming: [Movie] = [Movie]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureInitialViewController()
        return true
    }
    
    private func configureInitialViewController() {
        let initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window = UIWindow()
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "main")
        initialViewController = mainViewController
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
}

