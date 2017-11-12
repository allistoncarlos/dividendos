//
//  Dividend.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 20/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import Alamofire

final class Dividend: NSObject, ResponseSerializable {//, ParameterProtocol {
    var id:                 Int             = 0;
    var companyName:        String          = "";
    var companyID:          Int             = 0;
    var companyCNPJ:        String          = "";
    var approvationDate:    Date?           = Date.init();
    var exDate:             Date?           = Date.init();
    var paymentDate:        Date?           = Date.init();
    var pricePerStock:      String          = "";
    var dividendType:       DividendType    = .Dividends;
    var stockCodes:         String          = "";
    var fullNoticeUrl:      String?         = "";
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation              = representation                                        as? [String: Any],
            let id                          = representation["ID"]                                  as? Int,
            let companyName                 = representation["CompanyName"]                         as? String,
            let companyID                   = representation["CompanyID"]                           as? Int,
            let companyCNPJ                 = representation["CompanyCNPJ"]                         as? String,
            let approvationDate:    Date?   = DateHelpers.toDate(representation["ApprovationDate"]  as? String),
            let exDate:             Date?   = DateHelpers.toDate(representation["ExDate"]           as? String),
            let paymentDate:        Date?   = DateHelpers.toDate(representation["PaymentDate"]      as? String),
            let pricePerStock               = representation["PricePerStock"]                       as? String,
            let dividendType                = DividendType(rawValue: representation["Type"]         as! String),
            let stockCodes                  = representation["StockCodes"]                          as? String,
            let fullNoticeUrl:      String? = representation["FullNoticeURL"]                       as? String
            
            else { return nil }
        
        self.id                 = id;
        self.companyName        = companyName;
        self.companyID          = companyID;
        self.companyCNPJ        = companyCNPJ;
        self.approvationDate    = approvationDate;
        self.exDate             = exDate;
        self.paymentDate        = paymentDate;
        self.pricePerStock      = pricePerStock;
        self.dividendType       = dividendType;
        self.stockCodes         = stockCodes;
        self.fullNoticeUrl      = fullNoticeUrl;
    }
}
