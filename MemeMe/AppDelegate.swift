//
//  AppDelegate.swift
//  MemeMe
//
//  Created by Benzenhoefer, Moritz (059) on 03.03.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var storedMemes = [Meme]()
    // this can be commented out to have some initial memes provided
    /*[
        Meme(topText: "THAT SMELL", bottomText: "OF WEEKEND", originalImage: UIImage(named: "1.png")!, memedImage: UIImage(named: "1.png")!),
        Meme(topText: "SOME HEADER", bottomText: "SOME FOOTER", originalImage: UIImage(named: "2.png")!, memedImage: UIImage(named: "2.png")!),
        Meme(topText: "TOP", bottomText: "HEADER", originalImage: UIImage(named: "3.png")!, memedImage: UIImage(named: "3.png")!)
    ]*/

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

