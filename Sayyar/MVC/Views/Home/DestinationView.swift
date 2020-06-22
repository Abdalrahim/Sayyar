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
    
    @Binding var isDestination : Bool
    
//    @Published var selectedPlace: Place
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    
                    Image(isDestination ? "pasttopin" : "virtualPin")
                        .foregroundColor(purple)
                    
                    Text("where.to.go?")
                        .foregroundColor(Color(#colorLiteral(red: 0.8274509804, green: 0.8274509804, blue: 0.8274509804, alpha: 1)))
                        .font(.custom("Cairo-SemiBold", size: 15))
                        .onTapGesture {
                            self.showSearch()
                    }
                    
                }.padding(.init(top: 15, leading: 20, bottom: 0, trailing: 10))
                
                Divider().padding(.horizontal, 20).padding(.bottom, 7)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.places) { place in
                            PlaceView(place: place, selected: false)
                                .padding(.vertical, 1)
                                .onTapGesture {
                                    
                            }
                        }
                        
                        NewPlaceView(place: FavPlace(name: "Work", pType: .work, location: "Add location"))
                            .padding(.vertical, 1).onTapGesture {
                                self.newFav()
                        }
                        NewPlaceView(place: FavPlace(name: "Other", pType: .other, location: "Add location"))
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
            .background(RoundedCorners(color: bgColor, tl: 20, tr: 20, bl: 0, br: 0))
            .frame(height: 200)
            .padding(.bottom, 20)
        }.padding(.horizontal, 20)
    }
}

struct DestinationView_Previews: PreviewProvider {
    
    static var previews: some View {
        let places : [FavPlace] = [
            FavPlace(name: "home", pType: .home, location: "10mins"),
            FavPlace(name: "work", pType: .work, location: "30mins"),
            FavPlace(name: "meeting", pType: .other, location: "5mins")
        ]
        
        let supportedLocales: [Locale] = [
            "en",
            "ar",
            ].map(Locale.init(identifier:))
        
        return ForEach(supportedLocales, id: \.identifier) { locale in
            
            ForEach([ColorScheme.dark, .light], id: \.self) { scheme in
                DestinationView(places: places, addedPin: {}, showSearch: {}, newFav: {}, isDestination: .constant(true))
                    .previewLayout(.fixed(width: 500, height: 250))
                    .environment(\.locale, locale)
                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier)! + " \(scheme)")
                    .colorScheme(scheme)
                    .previewLayout(.fixed(width: 350, height: 200))
            }
        }
        
    }
}
