//
//  AppDelegate.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 28/06/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift
import Google

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Private Fields
    var window: UIWindow?

    // MARK: - Private Methods
    fileprivate func setupUI() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0/255.0, green: 118.0/255.0, blue: 255.0/255.0, alpha: 1.0);
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white];
        
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false);
    }
    
    // MARK: - UIApplication Delegate Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.setupUI();
        
        IQKeyboardManager.sharedManager().enable = true;
        
        if (SessionManager.shared.user != nil) {
            let mainViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainViewController") as! UITabBarController;
            self.window?.rootViewController = mainViewController;
        }
        
        // In-App Purchases
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.productPurchased(_:)),
                                               name: NSNotification.Name(rawValue: InAppPurchasesHelper.IAPHelperPurchaseNotification),
                                               object: nil);
        
        if (DividendsProducts.canReceiveNotifications()) {
            NotificationManager.registerForNotifications();
        }
        
        // Google Analytics
        // Configure tracker from GoogleService-Info.plist.
//        var configureError: NSError? = nil;
//        GGLContext.sharedInstance().configureWithError(&configureError);
//        assert(configureError == nil, "Error configuring Google services: \(configureError)");
        return true;
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FavoritesService.shared.getCloudUserId(completionHandler: { recordId, error in
            if let userID = recordId?.recordName {
                print("received iCloudID \(userID)")
                
                // iCloud
                SessionManager.shared.icloudUser = userID;
                
                if (application.isRegisteredForRemoteNotifications)
                {
                    let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
                    var tokenString = ""
                    
                    for i in 0..<deviceToken.count {
                        tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
                    }
                    
//                    PusharpService.shared.registerDevice(deviceToken: "\(tokenString)", userGroup: userID);
                }
            } else {
                print("Fetched iCloudID was nil")
            }
        });
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog(error.localizedDescription);
    }
    
    // MARK: - In-App Purchases
    func productPurchased(_ notification: Notification) {
        if (DividendsProducts.canReceiveNotifications()) {
            NotificationManager.registerForNotifications();
        }
    }
}

