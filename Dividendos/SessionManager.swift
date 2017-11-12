//
//  SessionManager.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 29/07/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

class SessionManager {
    // MARK: - Singleton
    static let shared = SessionManager();
    
    // MARK: - Properties
    var user: User? {
        set {
            UserDefaults.standard.set(self.objectArchiving(newValue!), forKey: "User");
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.object(forKey: "User") as? Data {
                return self.objectUnarchiving(data) as? User;
            }
            
            return nil;
        }
    }
    
    var tokenID: String? {
        set {
            UserDefaults.standard.set(self.objectArchiving(newValue! as AnyObject), forKey: "TokenID");
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.object(forKey: "TokenID") as? Data {
                return self.objectUnarchiving(data) as? String;
            }
            
            return nil;
        }
    }
    
    var secretKey: String? {
        set {
            UserDefaults.standard.set(self.objectArchiving(newValue! as AnyObject), forKey: "SecretKey");
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.object(forKey: "SecretKey") as? Data {
                return self.objectUnarchiving(data) as? String;
            }
            
            return nil;
        }
    }
    
    var icloudUser: String? {
        set {
            UserDefaults.standard.set(self.objectArchiving(newValue! as AnyObject), forKey: "iCloudUser");
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.object(forKey: "iCloudUser") as? Data {
                return self.objectUnarchiving(data) as? String;
            }
            
            return nil;
        }
    }
    
    // MARK: - Constructor
    fileprivate init() {
        
    }
    
    // MARK: - Private Methods
    fileprivate func objectArchiving(_ object: AnyObject) -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: object);
    }
    
    fileprivate func objectUnarchiving(_ object: Data) -> AnyObject {
        return NSKeyedUnarchiver.unarchiveObject(with: object)! as AnyObject;
    }
    
    // MARK: - Public Methods
    internal func logOut() {
        UserDefaults.standard.removeObject(forKey: "User");
        UserDefaults.standard.synchronize();
    }
}
