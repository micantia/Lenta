//
//  AppDelegate.swift
//  Lenta
//
//  Created by Alexandr Nesterenko on 18.04.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initRootController()
        return true
    }
    
    private func initRootController() {
        window = UIWindow(frame: UIScreen.main.bounds)

        let searchViewController = ViewControllerFactory
            .makeNewsListViewController(
                dependencyContainer: DependencyContainer.shared
            )
        
        let barItems: [RootBarItem: UIViewController] = [
            .topHighlights: UIViewController(),
            .search: searchViewController
        ]
        
        window?.rootViewController = RootTabBarController(barItems: barItems)
        
        window?.makeKeyAndVisible()
        
    }
}

