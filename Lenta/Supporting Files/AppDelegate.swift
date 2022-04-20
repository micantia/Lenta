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
        setupNavBarAppearance()
        return true
    }
    
    private func initRootController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let searchViewController = ViewControllerFactory
            .makeNewsListViewController(
                dependencyContainer: DependencyContainer.shared
            )
        
        let barItems: KeyValuePairs<RootBarItem, UIViewController> = [
            .topHighlights: UIViewController(),
            .search: searchViewController,
            .settings: UIViewController()
        ]
        
        window?.rootViewController = RootTabBarController(barItems: barItems)
        
        window?.makeKeyAndVisible()
        
    }
    
    private func setupNavBarAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.barStyle = .default
        appearance.isTranslucent = false
        
        if #available(iOS 15, *) {
            let customAppearance = UINavigationBarAppearance()
            customAppearance.titleTextAttributes = [
                NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 16)
            ]
            customAppearance.configureWithOpaqueBackground()
            
            appearance.standardAppearance = customAppearance
            appearance.scrollEdgeAppearance = customAppearance
        } else {
            appearance.titleTextAttributes = [
                NSAttributedString.Key.font: FontFamily.Gilroy.medium.font(size: 16),
            ]
        }
    }
}

