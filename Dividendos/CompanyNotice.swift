//
//  CompanyNotice.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 11/12/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

final class CompanyNotice: NSObject, ResponseSerializable {
    var date:                       Date?   = Date.init();
    var link:                       String  = "";
    var title:                      String  = "";
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation              = representation                                as? [String: Any],
            let date: Date?                 = DateHelpers.toDate(representation["Date"]     as? String),
            let link                        = representation["Link"]                        as? String,
            let title                       = representation["Title"]                       as? String
            else { return nil }
        
        self.date                       = date;
        self.link                       = link;
        self.title                      = title;
    }
}
