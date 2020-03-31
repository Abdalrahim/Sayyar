//
//  OrderView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

/// Order Part
struct DestinationView: View {
    
    @State var places : [FavPlace]
    
    var addedPin: () -> ()
    
    var showSearch: () -> ()
    
    var newFav: () -> ()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Image(systemName: "location.north.fill")
                        .rotationEffect(.degrees(180))
                        .foregroundColor(purple)
                    
                    Text("where.to.go?")
                        .foregroundColor(.gray)
                        .font(.custom("Cairo-SemiBold", size: 15))
                        .onTapGesture {
                            self.showSearch()
                    }
                    
                }.padding(.init(top: 15, leading: 20, bottom: 0, trailing: 20))
                
                Divider().padding(.horizontal, 30)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.places) { place in
                            PlaceView(place: place, selected: false)
                                .padding(.vertical, 1)
                        }
                        
                        NewPlaceView(place: FavPlace(name: "add.place", pType: .other, location: ""))
                            .padding(.vertical, 1).onTapGesture {
                                self.newFav()
                        }
                    }
                }.padding(.horizontal, 15)
                
                HStack(alignment: .center, spacing: 10) {
                    // MARK: Add Pin
                    Button(action: {
                        self.addedPin()
                    }) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("add.pin")
                                .font(.custom("Cairo-SemiBold", size: 20))
                                .foregroundColor(Color.white)
                                .alignmentGuide(.lastTextBaseline, computeValue: { d in
                                    d[.bottom] * 0.927
                                }
                            )
                            Spacer()
                        }
                    }.frame(height: 22, alignment: .center)
                        .padding()
                        .background(purple)
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
                .padding(.horizontal)
                
            }
            .background(Color("bg"))
            .cornerRadius(20)
            .frame(height: 200)
            .padding(.bottom, 20)
        }.padding(.horizontal, 20)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct DestinationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let places : [FavPlace] = [
            FavPlace(name: "home", pType: .home, location: "10mins"),
            FavPlace(name: "work", pType: .work, location: "30mins"),
            FavPlace(name: "meeting", pType: .other, location: "5mins")
        ]
        return DestinationView(places: places, addedPin: {}, showSearch: {}, newFav: {})
    }
}
