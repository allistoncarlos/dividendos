//
//  DividendModel.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 14/07/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

class DividendModel {
    var ID:                 Int?;
    var CompanyName:        NSString;
    var CompanyID:          Int?;
    var ApprovationDate:    Date?;
    var ExDate:             Date?;
    var PaymentDate:        Date?;
    var PricePerStock:      Float?;
    var DividendType:       NSString;
    
    init(dividend: NSDictionary) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC");
        dateFormatter.locale = Locale(identifier: "pt_BR");
        dateFormatter.formatterBehavior = DateFormatter.Behavior.default;
        
        ID                  = dividend["ID"]                as! Int?;
        CompanyName         = dividend["CompanyName"]       as! NSString;
        CompanyID           = dividend["CompanyId"]         as! Int?;
        PricePerStock       = dividend["PricePerStock"]     as? Float;
        DividendType        = dividend["Type"]              as! NSString;
        
        if let approvationDate = dividend["ApprovationDate"] as? String {
            ApprovationDate     = dateFormatter.date(from: approvationDate);
        }
        
        if let exDate = dividend["ExDate"] as? String {
            ExDate     = dateFormatter.date(from: exDate);
        }
        
        if let paymentDate = dividend["PaymentDate"] as? String {
            PaymentDate     = dateFormatter.date(from: paymentDate);
        }
    }
}
