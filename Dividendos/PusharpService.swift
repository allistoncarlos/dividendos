//
//  PusharpService.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 19/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import Alamofire

class PusharpService {
    // MARK: - Constants
    private static let PusharpPath      = "http://pusharp.azurewebsites.net/api/deviceapi";
    
    // MARK: - Singleton
    static let shared = PusharpService();
    
    // MARK: - Constructor
    private init() {
        
    }

    // MARK: - Methods
    func registerDevice(deviceToken: String, userGroup: String) {
        let parameters = [
            "ApplicationId": Constants.ApplicationID,
            "DeviceToken": deviceToken,
            "UserGroup": userGroup
        ]
        
        _ = Alamofire.request(PusharpService.PusharpPath, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        };
    }
}
