//
//  APIRoutes.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 06/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper
import Alamofire

protocol Router {
    
    var route: String { get }
    var baseURL: String { get }
    var parameters: OptionalDictionary { get }
    var method: Alamofire.HTTPMethod { get }
    var header : [String: String] {get}
    func handle(data: Any) -> AnyObject?
    func request(completion : @escaping Completion)
}
extension Sequence where Iterator.Element == Keys {
    
    func map(values: [Any?]) -> OptionalDictionary {
        
        var params = [String: Any]()
        
        for (index,element) in zip(self,values) {
            if element != nil {
                params[index.rawValue] = element
            }
        }
        return params
    }
}
