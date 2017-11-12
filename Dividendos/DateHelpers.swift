//
//  DateHelpers.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 20/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

class DateHelpers {
    static func toDate(_ string: String?) -> Date? {
        if (string == nil) {
            return nil;
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss";
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC");
        dateFormatter.locale = Locale(identifier: "pt_BR");
        dateFormatter.formatterBehavior = DateFormatter.Behavior.default;
        
        return dateFormatter.date(from: string!);
    }
}
