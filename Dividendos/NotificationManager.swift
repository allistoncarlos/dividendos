//
//  NotificationManager.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 28/07/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import UIKit

class NotificationManager {
    // MARK: - Singleton
    static let sharedInstance = NotificationManager();
    
    // MARK: - Constructor
    fileprivate init() {
        
    }
    
    // MARK: - Static Methods
    static func registerForNotifications() {
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil);
        
        UIApplication.shared.registerUserNotificationSettings(settings);
        UIApplication.shared.registerForRemoteNotifications();
    }
}
