//
//  RatePicker.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct RatePicker : View {
    
    @Binding var rate:Rating
    
    func starButton(index:Int) -> some View {
        let imageName = index <= rate.rawValue ? "star.fill" : "star"
        let color:Color = index <= rate.rawValue ? .yellow : .gray
        
        return
            Button(action: {
                self.rate = Rating(rawValue: index)!
            }) {
                Image(systemName:imageName)
                    .imageScale(.large)
                    .foregroundColor(color)
                    .frame(width:24, height: 24)
        }
    }
    
    var body: some View {
        HStack {
            ForEach(Range(1...5)) { id in
                self.starButton(index: id)
            }
        }
    }
}

enum Rating: Int,CaseIterable {
    
    case noRate = 0
    case terrible = 1
    case bad = 2
    case hmmm = 3
    case good = 4
    case brilliant = 5
    
    func descriptionForRating() -> String {
        switch self {
        case .noRate:
            return "Please rate:"
        case .terrible:
            return "Terrible"
        case .bad:
            return "Not good, not bad"
        case .hmmm:
            return "Hmm..."
        case .good:
            return "Gooood"
        case .brilliant:
            return "Brilliant!"
        }
    }
    
    func rate() -> Int {
        switch self {
        case .terrible:
            return 1
        case .bad:
            return 2
        case .hmmm:
            return 3
        case .good:
            return 4
        case .brilliant:
            return 5
        case .noRate:
            return 0
        }
    }
}
