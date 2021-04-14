//
//  RatingView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    
    @State var rate : Rating
    
    @State var textRating : String
    
    @Binding var showRating : Bool
    
    var body: some View {
        VStack {
            Text("how.was.trip?")
                .font(.custom("Cairo-Regular", size: 17))
                .padding(.top, 31)
            
            Image("person")
                .resizable()
                .scaledToFit()
                .frame(width: 64, height: 64)
                .cornerRadius(60)
            
            Text("Mohammed")
                .font(.custom("Cairo-Bold", size: 12))
            
            RatePicker(rate: self.$rate)
            TextView(text: self.$textRating).font(.custom("Cairo-SemiBold", size: 12))
                .frame(height: 100).padding(.all, 10).accentColor(purple)
            
            Button(action: {
                self.showRating.toggle()
            }, label: {
                Text("send").font(.custom("Cairo-Bold", size: 12)).foregroundColor((rate.rate() != 0) ? purple : Color.gray)
                
            }).padding(.bottom, 10)
        }
        .background(bgColor)
        .cornerRadius(10)
        .padding()
        .modifier(DismissingKeyboard())
    .shadow(radius: 5)
    }
}
struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rate: Rating(rawValue: 1)!, textRating: "Pls Rate", showRating: .constant(false)).padding()
            .previewLayout(.sizeThatFits)
    }
}
