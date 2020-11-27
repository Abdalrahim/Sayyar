//
//  PlaceView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct PlaceView : View {
    
    var place : FavPlace
    
    @State var selected : Bool
    
    var body : some View {
        return VStack(alignment: .center, spacing: 0) {
            
            Circle()
                .foregroundColor(self.selected ? Color(#colorLiteral(red: 0.6666666667, green: 0.6235294118, blue: 0.7215686275, alpha: 1)) : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)))
                .overlay(
                    
                    self.place.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    
            ).frame(height: 30)
            
            Text(self.place.name)
                .lineLimit(2)
                .font(.custom("Cairo-Bold", size: 13))
                .foregroundColor(Color(#colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)))
            
            Text(self.place.location)
                .font(.custom("Cairo-Regular", size: 10))
                .foregroundColor(.gray)
        }.frame(width: 75 , height: 75)
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(self.selected ? Color(#colorLiteral(red: 0.6666666667, green: 0.6235294118, blue: 0.7215686275, alpha: 1)) : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1))
            .onTapGesture {
                self.selected.toggle()
        }
        
    }
}

struct NewPlaceView : View {
    
    var place : FavPlace
    
    var body : some View {
        VStack(alignment: .center, spacing: 0) {
            
            Circle()
                .foregroundColor(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)))
                .overlay(
                    
                    self.place.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 18, height: 18)
                    
            ).frame(height: 30)
            
            Text(self.place.name).lineLimit(2)
                .font(.custom("Cairo-Bold", size: 13))
                .foregroundColor(Color(#colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)))
            Text(self.place.location)
            .font(.custom("Cairo-Regular", size: 10))
                .foregroundColor(.gray)
            
        }.frame(width: 75 , height: 75)
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1)
        )
    }
}



struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView(place: FavPlace(name: "home", pType: .work, location: "10mins"), selected: true)
            .previewLayout(.fixed(width: 75, height: 75))
    }
}

struct NewPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlaceView(place: FavPlace(name: "home", pType: .home, location: "10mins"))
            .previewLayout(.fixed(width: 75, height: 75))
    }
}
