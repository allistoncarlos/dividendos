//
//  CompanyNoticeService.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 11/12/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation

class CompanyNoticeService: APIService<CompanyNotice> {
    private static let resource: String = "companynotice";
    
    // MARK: - Singleton
    static let shared = CompanyNoticeService();
    
    // MARK: - Constructor
    private override init() {
        
    }
    
    func getNotices(id: Int, success: @escaping ([CompanyNotice]) -> Void, failure: @escaping (Array<ServiceError>) -> Void) {
        super.getCollection(resource: CompanyNoticeService.resource,
                            allowAnonymousAccess: false,
                            id: "\(id)",
                            success: { result in
                                if (result.ok) {
                                    success(result.data!);
                                }
                                else {
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
