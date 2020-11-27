//
//  AppDelegate.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 02/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import IQKeyboardManagerSwift
import UserNotifications

let GMSApiKey = "AIzaSyBYrozEJFm7MjTGed7ZqtXVObMgZzchYEo"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let geoCoder = CLGeocoder()
    let center = UNUserNotificationCenter.current()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(GMSApiKey)
        
        FirebaseApp.configure()
        Firestore.firestore()
        IQKeyboardManager.shared.enable = true
        UNUserNotificationCenter.current().delegate = self
        setUpForRemoteNotification(application)
        
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
    
    
}


extension AppDelegate : UNUserNotificationCenterDelegate , MessagingDelegate {
    // SetUp For Remote Notification
    func setUpForRemoteNotification(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { (didAllow, error) in
                    
            })
            
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        print("Firebase registration token: \(fcmToken)")
        let dataDict:[String: String] = ["token": fcmToken]
        
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfos = notification.request.content.userInfo
        
        // Print full message.
        print("userNotificationCenter", userInfos)
        
        if let userInfo = userInfos as? [String : Any] {
            
            // Print full message.
            print("userNotificationCenter",userInfo)
            
            
            completionHandler([])
        }
        
        // Change this to your preferred presentation option
        completionHandler([.badge , .sound , .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let userInfo = response.notification.request.content.userInfo as? [String : Any] {
            
            // Print full message.
            print(userInfo)
            
            
        }
        completionHandler()
    }
    
}
