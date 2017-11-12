//
//  Token.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 20/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

final class Token: NSObject, ResponseSerializable {
    var id:                 String  = ""
    var secretKey:          String  = "";
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation  = representation                    as? [String: Any],
            let id              = representation["ID"]              as? String,
            let secretKey       = representation["SecretKey"]       as? String
            
            else { return nil }
        
        self.id                 = id;
        self.secretKey          = secretKey;
    }
    
    override init() {
        super.init();
    }
}
