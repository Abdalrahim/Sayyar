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
    
    @EnvironmentObject var settings: UserSettings
    
//    @Published var selectedPlace: Place
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Image(systemName: "location.north.fill")
                        .rotationEffect(.degrees(180))
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
            .edgesIgnoringSafeArea(.bottom)
    }
}

class UserSettings: ObservableObject {
    @Published var score = 0
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
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
            .previewLayout(.fixed(width: 500, height: 250))
    }
}
