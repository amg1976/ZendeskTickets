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

   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

      self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
      if let window = self.window {

         let vc = ViewController()
         window.rootViewController = vc

         window.backgroundColor = UIColor.redColor()
         window.makeKeyAndVisible()
      }
      
      return true
   }

}

