//
//  APIResult.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 19/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

final class APIResult: ResponseSerializable {
    var ok:         Bool                    = false;
    var errors:     Array<NSDictionary>?    = Array<NSDictionary>();
    
    init?(response: HTTPURLResponse, representation: Any) {
        var serializedJSON = representation     as? [String: Any];
        let requestOK = serializedJSON?["Ok"]   as! Bool;
        
        if (!requestOK) {
            guard
                let representation  = representation                as? [String: Any],
                let ok              = representation["Ok"]          as? Bool,
                let errors          = representation["Errors"]      as? Array<NSDictionary>
            
                else { return nil }
            
            self.ok         = ok;
            self.errors     = errors;
        }
        else {
            guard
                let representation  = representation                as? [String: Any],
                let ok              = representation["Ok"]          as? Bool
                
                else { return nil }
            
            self.ok         = ok;
        }
    }
}

final class APIObjectResult<T: ResponseSerializable>: ResponseSerializable {
    var ok:         Bool                    = false;
    var errors:     Array<NSDictionary>?    = Array<NSDictionary>();
    var data:       T?;
    
    init?(response: HTTPURLResponse, representation: Any) {
        var serializedJSON = representation     as? [String: Any];
        let requestOK = serializedJSON?["Ok"]   as! Bool;
        
        if (!requestOK) {
            guard
                let representation  = representation                as? [String: Any],
                let ok              = representation["Ok"]          as? Bool,
                let errors          = representation["Errors"]      as? Array<NSDictionary>
        
            else { return nil }
        
            self.ok         = ok;
            self.errors     = errors;
        }
        else {
            guard
                let representation  = representation                as? [String: Any],
                let ok              = representation["Ok"]          as? Bool,
                let data            = T(response:response, representation: representation["Data"])
                
                else { return nil }
            
            self.ok         = ok;
            self.data       = data;
        }
    }
}

final class APICollectionResult<T: ResponseSerializable>: ResponseSerializable {
    var ok:         Bool                    = false;
    var errors:     Array<NSDictionary>?    = Array<NSDictionary>();
    var data:       [T]?;
    
    init?(response: HTTPURLResponse, representation: Any) {
        
        var serializedJSON = representation     as? [String: Any];
        let requestOK = serializedJSON?["Ok"]   as! Bool;
        
        if (!requestOK) {
            guard
                let representation  = representation                as? [String: Any],
                let ok              = representation["Ok"]          as? Bool,
                let errors          = representation["Errors"]      as? Array<NSDictionary>
                
                else { return nil }
            
            self.ok         = ok;
            self.errors     = errors;
        }
        else {
            guard
                let representation  = representation                as? [String: Any],
                let ok              = representation["Ok"]          as? Bool,
                let data            = T.collection(from: response, withRepresentation: representation["Data"]) as? [T]
                
                else { return nil }
            
            self.ok         = ok;
            self.data       = data;
        }
    }
}
