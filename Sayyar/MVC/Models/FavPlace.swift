//
//  FavPlace.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct FavPlace : Identifiable {
    var id = UUID()
    
    var name : String
    
    var placename : String?
    
    var pType : favPlacetype
    
    var selected: Bool = false
    
    var image : Image {
        switch pType {
        case .home:
            return Image("home")
        case .work:
            return Image("work")
        case .place:
            return Image("fav")
        case .add:
            return Image(systemName: "plus.circle.fill").personCircle(diameter: 30)
        case .other:
            return Image("fav")
        }
    }
    var location : String
    
}

enum favPlacetype : Int {
    case home = 0
    case work = 1
    case other = 2
    case place = 3
    case add = 4
}
