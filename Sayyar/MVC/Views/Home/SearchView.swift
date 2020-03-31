//
//  SearchView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct SearchView : View {
    @State var textRating : String = ""
    @State var places : [FavPlace] = [
        FavPlace(name: "home", pType: .home, location: "10mins"),
        FavPlace(name: "work", pType: .work, location: "30mins"),
        FavPlace(name: "meeting", pType: .other, location: "5mins"),
        FavPlace(name: "meeting", pType: .place, location: "5mins")
    ]
    
    var body: some View {
        VStack {
            
            SearchBar(searchText: self.$textRating, search: {
                print(self.textRating)
            })
            
            Divider().shadow(color: .black, radius: 1, y: 1)
            List(places) {place in
                SearchCell(place: place, selectedPlace: nil)
            }
            Spacer()
        }
    }
}

struct SearchBar : View {
    @Binding var searchText: String
    var search: () -> ()
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.secondary)
            TextField("Search", text: $searchText, onEditingChanged: { changed in
                print(changed)
            }) {
                self.search()
            }
            
            Button(action: {
                self.searchText = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
                    .opacity(searchText == "" ? 0.0 : 1.0)
            }
        }.frame(height: 44).padding(.horizontal)
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1)
        ).padding()
    }
}

struct SearchCell : View {
    
    var place : FavPlace
    var selectedPlace : FavPlace?
    
    var body: some View {
        HStack {
            
            self.place.image
            .resizable()
            .scaledToFill()
            .frame(width: 35, height: 35)
            
            VStack(alignment: .leading) {
                Text(place.name).font(.custom("Cairo-SemiBold", size: 18))
                Text(place.name).font(.custom("Cairo-SemiBold", size: 16)).foregroundColor(Color.init(white: 0.8))
            }
            Spacer()
            Image(systemName: "star.fill")
                .foregroundColor(purple)
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
