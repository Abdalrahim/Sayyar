//
//  OrderData.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 15/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct PastOrderData : Identifiable {
    var id = UUID()
    
    var status : OrderStatus
    
    var driverName : String
    
    var price : Int
    
    var time : Date
    
    var fromPlace : String
    
    var toPlace : String
    
    var rating : Int
}

enum OrderStatus : Int {
    case cash = 0
    case credit = 1
    case cancelled = 2
    
    func desc() -> String {
        switch self {
        case .cash:
            return "Cash"
        case .credit:
            return "Credit"
        case .cancelled:
            return "Cancelled"
        }
    }
}
