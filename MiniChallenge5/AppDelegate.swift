//
//  AppDelegate.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 06/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var preferencesDataManager: PreferencesDataManager = PreferencesDataManager()
    private var playerDataManager: PlayerDataManager = PlayerDataManager()
    var circuit: Circuit!
    
    var preferesStatusBarHidden: Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        self.circuit = nil
        DispatchQueue.main.async {
            if let token = self.preferencesDataManager.token{
                self.playerDataManager.readByToken(token: token) {
                    if let player = $0{
                        let session: Session = Session(player: player, token: token)
                        Session.shared = session
                    }
                }

            }else{
                    print("Ther isn't internet connection!")
            }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            let mainMenuViewController = storyboard.instantiateViewController(withIdentifier: "MainMenu")
            let navigationController = UINavigationController(rootViewController: mainMenuViewController)
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()

        }
    

    }

    
}

