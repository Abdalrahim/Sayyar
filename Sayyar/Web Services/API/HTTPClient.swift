//
//  HTTPClient.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 06/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

typealias HttpClientSuccess = (Any?) -> ()
typealias HttpClientFailure = (String) -> ()


enum ResponseStatus : Int { //enum for response status getting from server End
    
    case success = 200
    case created = 201
    case badRequest = 400
    case unAuthorizedAccess = 401
    case serverNotFound = 404
    case internalServerError = 500
    
    
    init?(value : Int) {
        self.init(rawValue: value)
    }

}


class HTTPClient : NSObject {
    
    func postRequest(withApi api: Router, success: @escaping HttpClientSuccess, failure: @escaping HttpClientFailure) {
        
        let params = api.parameters
        let fullPath = api.baseURL + api.route
        let method = api.method
        
        debugPrint(api.method)
        debugPrint(fullPath)
        debugPrint(params ?? "")
        debugPrint(api.header)
        
        Alamofire.request(fullPath, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            guard let data = response.data else {
                return
            }
            let json = JSON(data)
//            debugPrint(json)

            if let status = response.response?.statusCode {

                let responseStatus  = ResponseStatus.init(value: status)

                switch(responseStatus) {

                case .success?, .created?:
                    switch response.result {

                    case .success(let data):
                        success(data)

                    case .failure(let error):
                        failure(error.localizedDescription)
                    }

                case .badRequest?, .unAuthorizedAccess? , .serverNotFound? , .internalServerError?:
                    failure(json[APIConstants.message.rawValue].stringValue)
                    if json[APIConstants.success.rawValue].stringValue == Validate.invalidAccessToken.rawValue {
                        self.tokenExpired()
                    }

                case .none:
                    failure(json[APIConstants.message.rawValue].stringValue)
                }
            } else {
                debugPrint("No Response",response.result)
            }
        }
    }
    
    
    //MARK : - get Header
    func headerNeeded(api : Router) -> Bool {
        
        switch api.route {
            
        default:
            return false
        }
    }
}
