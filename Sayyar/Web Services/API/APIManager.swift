//
//  APIManager.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 07/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation
import Alamofire
typealias Completion = (Response) -> ()

class APIManager: ObservableObject {
    @Published var shared = HTTPClient()
    
    var tokenExpiredFlag = 0
    
    
    func request(with api: Router , completion: @escaping Completion)  {
        
        if !(Alamofire.NetworkReachabilityManager()?.isReachable ?? false) {
            return completion(Response.failure("NoInternetConnection".localized))
        }
        
        
        shared.postRequest(withApi: api,success: { (data) in
            
            
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            let object : Any? = api.handle(data: response)
            completion(Response.success(object))
            return
            
        }, failure: { (message) in
            completion(Response.failure(message))
            
        })
    }
}
