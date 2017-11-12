//
//  RegisterUserModel.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 23/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import Alamofire

final class RegisterUserModel: NSObject, ParameterProtocol {
    var id:         Int                     = 0;
    var firstName:  String                  = "";
    var lastName:   String                  = "";
    var email:      String                  = "";
    var password:   String                  = "";

    func parameters() -> [String : Any] {
        let parameters: Parameters = [
            #keyPath(RegisterUserModel.id):          self.id,
            #keyPath(RegisterUserModel.firstName):   self.firstName,
            #keyPath(RegisterUserModel.lastName):    self.lastName,
            #keyPath(RegisterUserModel.email):       self.email,
            #keyPath(RegisterUserModel.password):    self.password
        ];
        
        return parameters
    }
}
