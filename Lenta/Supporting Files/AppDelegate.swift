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
        
        let controller = NewsListViewController()
        controller.viewModel = DependencyContainer.makeNewsListViewModel()
        
        window?.rootViewController = UINavigationController(
            rootViewController: controller
        )
        window?.makeKeyAndVisible()
        
    }
}

