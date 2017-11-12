//
//  CompanyService.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 23/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

class CompanyService: APIService<Company> {
    private static let resource: String = "company";
    
    // MARK: - Singleton
    static let shared = CompanyService();
    
    // MARK: - Constructor
    private override init() {
        
    }
    
    func getCompanies(success: @escaping ([Company]) -> Void, failure: @escaping (Array<ServiceError>) -> Void) {
        super.getCollection(resource: CompanyService.resource,
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
