//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 03.03.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // TODO: revert to [Meme](), remove assets
    var storedMemes = [
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(named: "1.png")!, memedImage: UIImage(named: "1.png")!),
        Meme(topText: "top", bottomText: "2", originalImage: UIImage(named: "2.png")!, memedImage: UIImage(named: "2.png")!),
        Meme(topText: "top", bottomText: "3", originalImage: UIImage(named: "3.png")!, memedImage: UIImage(named: "3.png")!),
        Meme(topText: "top", bottomText: "4", originalImage: UIImage(named: "2.png")!, memedImage: UIImage(named: "2.png")!),
        Meme(topText: "top", bottomText: "5", originalImage: UIImage(named: "3.png")!, memedImage: UIImage(named: "3.png")!)
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }


}

