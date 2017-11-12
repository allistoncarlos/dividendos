//
//  FavoritesService.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 16/10/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class FavoritesService: APIService<Favorite> {
    private static let resource: String = "favorite";
    
    // MARK: - Singleton
    static let shared = FavoritesService();
    
    // MARK: - Private Fields
    let privateDatabase = CKContainer.default().privateCloudDatabase;
    
    // MARK: - Properties
    var favoriteCompanies: [Int] = [Int]();
    
    // MARK: - Methods
    func getCloudUserId(completionHandler complete: @escaping (_ instance: CKRecordID?, _ error: NSError?) -> ()) {
        CKContainer.default().fetchUserRecordID(completionHandler: { recordId, error in
            if error != nil {
                print(error!.localizedDescription);
                complete(nil, error as NSError?);
            } else {
                print("fetched ID \(recordId?.recordName)");
                complete(recordId, nil);
            }
        });
    }
    
    func get() {
        if (SessionManager.shared.icloudUser == nil) {
            self.getCloudUserId(completionHandler: { recordId, error in
                if let userID = recordId?.recordName {
                    // iCloud
                    SessionManager.shared.icloudUser = userID;
                    
                    self.get(userGroup: userID, success: self.favoriteSuccess, failure: { error in });
                } else {
                    print("Fetched iCloudID was nil");
                }
            });
        }
        else {
            self.get(userGroup: SessionManager.shared.icloudUser!, success: self.favoriteSuccess, failure: { error in });
        }
    }
    
    private func get(userGroup: String, success: @escaping ([Favorite]) -> Void, failure: @escaping (Array<ServiceError>) -> Void) {
        self.getCollection(resource: FavoritesService.resource,
                            allowAnonymousAccess: false,
                            id: userGroup,
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
                            });
    }
    
    private func favoriteSuccess(favorites: [Favorite]) {
        if (favorites.count > 0) {
            self.favoriteCompanies = [Int]();
        }
        
        for favorite in favorites {
            self.favoriteCompanies.append(favorite.companyId);
        }
    }
    
    func save(companyId: Int, completionHandler: @escaping (Error?) -> Void) {
        let parameters: [String: Any] = [
            "CompanyId": companyId,
            "UserGroup": SessionManager.shared.icloudUser!
        ];
        
        self.post(resource: FavoritesService.resource,
                   allowAnonymousAccess: false,
                   parameters: parameters,
                   success: { result in
                       self.favoriteCompanies.append(companyId);
                       completionHandler(nil);
                   }, failure: { error in
                       completionHandler(error);
                   });
    }
    
    func delete(companyId: Int, completionHandler: @escaping (Error?) -> Void) {
        let parameters: [String: Any] = [
            "CompanyId": companyId,
            "UserGroup": SessionManager.shared.icloudUser!
        ];
        
        self.delete(resource: FavoritesService.resource,
                  allowAnonymousAccess: false,
                  parameters: parameters,
                  success: { result in
                      self.favoriteCompanies.remove(at: (self.favoriteCompanies.index(of: companyId))!);
                      completionHandler(nil);
                  },
                  failure: { error in
                      completionHandler(error);
                  });
    }
}
