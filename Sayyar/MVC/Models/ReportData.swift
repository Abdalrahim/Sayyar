//
//  ReportData.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 29/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation

struct ReportData : Identifiable {
    var id = UUID()
    
    var title : String
    var reportNum : Int
    var type : String
    var reportDate : Date
    var status : ReportStatus
    var message : String
    var sayyarMessage : String
    
}

enum ReportStatus : Int {
    case closed = 0
    case step1 = 1
    case step2 = 2
    case step3 = 3
    
    func desc() -> String {
        switch self {
        case .closed:
            return "Closed"
        default:
            return "Pending"
        }
    }
}
