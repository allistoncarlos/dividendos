//
//  Company.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 23/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

final class Company: NSObject, ResponseSerializable {//, ParameterProtocol {
    var id:                         Int     = 0;
    var name:                       String  = "";
    var cnpj:                       String  = "";
    var site:                       String  = "";
    var companyCodes:               String  = "";
    var mainActivity:               String  = "";
    var sectorialClassification:    String  = "";
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation              = representation                                as? [String: Any],
            let id                          = representation["ID"]                          as? Int,
            let site                        = representation["Site"]                        as? String,
            let name                        = representation["Name"]                        as? String,
            let companyID                   = representation["CNPJ"]                        as? String,
            let companyCodes                = representation["CompanyCodes"]                as? String,
            let mainActivity                = representation["MainActivity"]                as? String,
            let sectorialClassification     = representation["SectorialClassification"]     as? String
        
            else { return nil }
        
        self.id                         = id;
        self.name                       = name;
        self.site                       = site;
        self.cnpj                       = companyID;
        self.companyCodes               = companyCodes;
        self.mainActivity               = mainActivity;
        self.sectorialClassification    = sectorialClassification;
    }
}
