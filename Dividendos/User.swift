//
//  User.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 19/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import Alamofire

final class User: NSObject, NSCoding, ResponseSerializable, ParameterProtocol {
    var id:         Int                     = 0;
    var firstName:  String                  = "";
    var lastName:   String                  = "";
    var email:      String                  = "";
    var token:      Token                   = Token();
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation  = representation                as? [String: Any],
            let id              = representation["ID"]          as? Int,
            let firstName       = representation["FirstName"]   as? String,
            let lastName        = representation["LastName"]    as? String,
            let email           = representation["Email"]       as? String,
            let token           = Token(response: response, representation: representation["Token"])
            
            else { return nil }
        
        self.id         = id;
        self.firstName  = firstName;
        self.lastName   = lastName;
        self.email      = email;
        self.token      = token;
    }
    
    override init() {
        super.init();
    }
    
    private init(id: Int, firstName: String, lastName: String, email: String) {
        self.id          = id;
        self.firstName   = firstName;
        self.lastName    = lastName;
        self.email       = email;
    }
    
    func parameters() -> [String : Any] {
        let parameters: Parameters = [
            #keyPath(User.id):          self.id,
            #keyPath(User.firstName):   self.firstName,
            #keyPath(User.lastName):    self.lastName,
            #keyPath(User.email):       self.email
        ];
        
        return parameters
    }
    
    // MARK: NSCoding
    public convenience init?(coder aDecoder: NSCoder) {
        let id          = aDecoder.decodeInteger(forKey: #keyPath(User.id));
        let firstName   = aDecoder.decodeObject(forKey: #keyPath(User.firstName))   as! String;
        let lastName    = aDecoder.decodeObject(forKey: #keyPath(User.lastName))    as! String;
        let email       = aDecoder.decodeObject(forKey: #keyPath(User.email))       as! String;
        
        self.init(id: id, firstName: firstName, lastName: lastName, email: email);
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: #keyPath(User.id));
        aCoder.encode(self.firstName,  forKey: #keyPath(User.firstName));
        aCoder.encode(self.lastName,   forKey: #keyPath(User.lastName));
        aCoder.encode(self.email,      forKey: #keyPath(User.email));
    }
}
