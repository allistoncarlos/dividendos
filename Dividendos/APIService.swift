//
//  APIService.swift
//  Dividendos
//
//  Created by Alliston Aleixo on 19/09/16.
//  Copyright © 2016 Alliston Aleixo. All rights reserved.
//

import Foundation
import Alamofire

public class APIService<T: ResponseSerializable> {
    // MARK: - Constants
    let BasePath: String = "http://dividendos.azurewebsites.net/api/";
    
    // MARK: - Private Methods
    private func setupHeaders() -> [String: String] {
        return [
            "Id":           "1",
            "SecretKey":    "N7nF2j/LcKoNHWlIrpQNZ7rb2Jg+uLKb9ll/Cb+QrXnzufJ3dAI="
        ];
    }
    
    // MARK: - API Methods
    func getCollection(resource: String, allowAnonymousAccess: Bool = true, success: @escaping (APICollectionResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        var request: DataRequest;
        
        let resultPath = "\(BasePath)\(resource)";
        debugPrint(resultPath);
        
        if (allowAnonymousAccess) {
            request = Alamofire.request(resultPath, method: .get, encoding: JSONEncoding.default);
        }
        else {
            request = Alamofire.request(resultPath, method: .get, encoding: JSONEncoding.default, headers: setupHeaders());
        }
        
        self.requestCollection(request: request, success: success, failure: failure);
    }
    
    func getCollection(resource: String, allowAnonymousAccess: Bool = true, id: String, success: @escaping (APICollectionResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        var request: DataRequest;
        
        let resultPath = "\(BasePath)\(resource)/\(id)";
        debugPrint(resultPath);
        
        if (allowAnonymousAccess) {
            request = Alamofire.request(resultPath, method: .get, encoding: JSONEncoding.default);
        }
        else {
            request = Alamofire.request(resultPath, method: .get, encoding: JSONEncoding.default, headers: setupHeaders());
        }
        
        self.requestCollection(request: request, success: success, failure: failure);
    }
    
    func getSingle(resource: String, allowAnonymousAccess: Bool = true, id: String, success: @escaping (APIObjectResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        var request: DataRequest;
        
        let resultPath = "\(BasePath)\(resource)/\(id)";
        debugPrint(resultPath);
        
        if (allowAnonymousAccess) {
            request = Alamofire.request(resultPath, method: .get, encoding: JSONEncoding.default);
        }
        else {
            request = Alamofire.request(resultPath, method: .get, encoding: JSONEncoding.default, headers: setupHeaders());
        }
        
        self.requestSingleObject(request: request, success: success, failure: failure);
    }
    
    func post(resource: String, allowAnonymousAccess: Bool = true, parameters: Parameters, success: @escaping (APIObjectResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        var request: DataRequest;
        
        let resultPath = "\(BasePath)\(resource)";
        debugPrint(resultPath);
        
        if (allowAnonymousAccess) {
            request = Alamofire.request(resultPath, method: .post, parameters: parameters, encoding: JSONEncoding.default);
        }
        else {
            request = Alamofire.request(resultPath, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: setupHeaders());
        }
        
        self.requestSingleObject(request: request, success: success, failure: failure);
    }
    
    func put(resource: String, allowAnonymousAccess: Bool = true, id: Int, parameters: Parameters, success: @escaping (APIObjectResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        var request: DataRequest;
        
        let resultPath = "\(BasePath)\(resource)/\(id)";
        debugPrint(resultPath);
        
        if (allowAnonymousAccess) {
            request = Alamofire.request(resultPath, method: .put, parameters: parameters, encoding: JSONEncoding.default);
        }
        else {
            request = Alamofire.request(resultPath, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: setupHeaders());
        }
        
        self.requestSingleObject(request: request, success: success, failure: failure);
    }
    
    func delete(resource: String, allowAnonymousAccess: Bool = true, parameters: Parameters, success: @escaping (APIResult) -> Void, failure: @escaping (Error?) -> Void) {
        var request: DataRequest;
        
        let resultPath = "\(BasePath)\(resource)/";
        debugPrint(resultPath)
        
        if (allowAnonymousAccess) {
            request = Alamofire.request(resultPath, method: .delete, parameters: parameters, encoding: JSONEncoding.default);
        }
        else {
            request = Alamofire.request(resultPath, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: setupHeaders());
        }
        
        _ = request.response { (response: DataResponse<APIResult>) in
            switch response.result {
                case .success:
                    success(response.result.value!);
                case .failure:
                    failure(response.result.error);
            }
        }
    }
    
    // MARK: - Private Method
    func requestSingleObject(request: DataRequest, success: @escaping (APIObjectResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        _ = request.response { (response: DataResponse<APIObjectResult<T>>) in
            switch response.result {
                case .success:
                    success(response.result.value!);
                case .failure:
                    failure(response.result.error);
            }
        }
    }
    
    func requestCollection(request: DataRequest, success: @escaping (APICollectionResult<T>) -> Void, failure: @escaping (Error?) -> Void) {
        _ = request.response { (response: DataResponse<APICollectionResult<T>>) in
            switch response.result {
                case .success:
                    success(response.result.value!);
                case .failure:
                    failure(response.result.error);
            }
        }
    }
}
