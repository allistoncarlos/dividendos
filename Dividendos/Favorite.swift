//
//  Favorite.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 06/12/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

final class Favorite: NSObject, ResponseSerializable {//, ParameterProtocol {
    var companyId:                  Int     = 0;
    var userGroup:                  String  = "";
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation              = representation                                as? [String: Any],
            let companyId                   = representation["CompanyId"]                   as? Int,
            let userGroup                   = representation["UserGroup"]                   as? String
            
            else { return nil }
        
        self.companyId                  = companyId;
        self.userGroup                  = userGroup;
    }
}
