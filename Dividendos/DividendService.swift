//
//  DividendService.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 20/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

class DividendService: APIService<Dividend> {
    private static let resource: String = "dividend";
    
    // MARK: - Singleton
    static let shared = DividendService();
    
    // MARK: - Constructor
    private override init() {
        
    }
    
    func getDividends(success: @escaping ([Dividend]) -> Void, failure: @escaping (Array<ServiceError>) -> Void) {
        super.getCollection(resource: DividendService.resource,
            allowAnonymousAccess: false,
            success: { result in
                if (result.ok) {
                    success(result.data!);
                }else {
                    var resultErrors = Array<ServiceError>();

                    for error in result.errors! {
                        resultErrors.append(ServiceError(dictionary: error));
                    }

                    failure(resultErrors);
                }
            },
            failure: { error in
                failure([ServiceError()]);
            }
        );
    }
}
