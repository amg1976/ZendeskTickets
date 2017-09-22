//
//  AppDelegate.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            
            let vc = TicketsListViewController(apiService: ZendeskApiService())
            window.rootViewController = vc
            
            window.backgroundColor = UIColor.red
            window.makeKeyAndVisible()
        }
        
        return true
    }
    
}

