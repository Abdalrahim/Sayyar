//
//  OfferCard.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 01/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import GoogleMaps
import UIKit
import SpriteKit

struct OfferCard: View {
    @State var offer : OfferData
    @Binding var page : Int
    var width : CGFloat
    
    var body: some View {
        VStack {
            HStack {
                Image("person")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 60)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1))
                            .foregroundColor(.gray)
                )
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(offer.driverName)
                            .font(.custom("Cairo-SemiBold", size: 12))
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.yellow)
                            .frame(width: 13, height: 13)
                        
                        Text("\(NSNumber(value: offer.rating))")
                            .font(.custom("Cairo-SemiBold", size: 10))
                            .padding(.horizontal, -6)
                    }
                    
                    HStack {
                        Text("\(offer.carMake) • \(offer.carModel)"+" • \(offer.carYear)")
                            .font(.custom("Cairo-SemiBold", size: 12))
                        if offer.isTaxi ?? false {
                            Image("taxi-sign")
                        }
                    }
                    
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Spacer()
                    Text("timer")
                        .font(.custom("Cairo-SemiBold", size: 10))
                    ProgressCircle(time: self.offer.time)
                }
            }.padding(.horizontal, 10)
            
            HStack {
                HStack {
                    Image("location")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                    
                    Text("\(NSNumber(value: offer.rating)) km")
                        .font(.custom("Cairo-SemiBold", size: 12))
                }
                
                Spacer()
                
                HStack {
                    Image("cash")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 15)
                    
                    Text("\(NSNumber(value: offer.price)) "+"sr".localized)
                        .font(.custom("Cairo-SemiBold", size: 12))
                }
                Spacer()
                HStack {
                    Image("time")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                    
                    
                    Text(String.localizedStringWithFormat("min".localizewithnumber(count: UInt(((offer.time % 3600) / 60)))))
                        .font(.custom("Cairo-SemiBold", size: 12))
                }
            }
            .padding(.horizontal)
            
            NavigationLink(destination: OrderView()) {
                Text("accept.offer")
                    .font(.custom("Cairo-SemiBold", size: 12))
                    .foregroundColor(Color.white)
            }
            .padding(20)
            .frame(height : 35)
            .background(purple)
            .cornerRadius(5)
            
        }
        .padding()
        .frame(width: self.page == self.offer.id ? self.width - 30 : self.width + 20, height: (self.page == self.offer.id ? 220 : 240))
        .foregroundColor(dark)
        .background(bgColor)
        .cornerRadius(10)
        .padding(.vertical, self.page == offer.id ? 0 : 20)
        .padding(.horizontal, self.page == offer.id ? 10 : 40)
        .frame(width: self.width)
//        .animation(.default)
    }
}

struct OfferCard_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let offer : OfferData =
            OfferData(
                id: 1,
                driverName: "Mohammed",
                rating: 4.5,
                carMake: "Toyota",
                carModel: "Camry",
                carYear: 2019,
                distance: 40.0,
                timeDistance: 25,
                price: 12.5,
                time: 60,
                location : CLLocationCoordinate2D(latitude: 21.542289948557013, longitude: 39.18610509485006),
                show: false
        )
        let supportedLocales: [Locale] = [
            "en",
            "ar",
            ].map(Locale.init(identifier:))
        
        return ForEach(supportedLocales, id: \.identifier) { locale in
            
            ForEach([ColorScheme.dark, .light], id: \.self) { scheme in
                
                VStack {
                    
                    Spacer()
                    OfferCard(offer: offer, page: .constant(0), width: 300)
                }
                .padding()
                .background(gray.edgesIgnoringSafeArea(.all))
                .environment(\.locale, locale)
                .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
                .colorScheme(scheme)
                
            }
        }
        
    }
}

struct ProgressCircle: View {
    
    @State var time : Int
    @State var starter : Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
//    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
//        let frame = geometry.frame(in: .global)
//        return frame.size.width * value
//    }
    
    func getPercentage(_ value:CGFloat) -> String {
        let intValue = Int(ceil(value * 100))
        return "\(intValue) %"
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray,
                        style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .butt,
                        dash: [2,3]))
                .frame(width: 45)
            
            Circle()
                .trim(from: starter ? 0 : 1, to: 1)
                .stroke(purple,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .butt))
                .frame(width:45)
                .animation(Animation.linear(duration: Double(time)).delay(1))
                .rotationEffect(Angle(degrees:-90))
            
            Text(secsToMinsAndSecs(seconds: time))
                .font(.custom("Cairo-Bold", size: 11))
                .foregroundColor(purple)
        }
        .padding(.horizontal, 2)
        .drawingGroup()
        .onAppear {
            self.starter = true
        }.onReceive(timer) { input in
            withAnimation(.linear) {
                if (self.time != 0) {
                    self.time -= 1
                }
            }
        }
    }
}

func secsToMinsAndSecs(seconds : Int) -> String {
    let minutes = "\((seconds % 3600) / 60)"
    let seconds = "\((seconds % 3600) % 60)"
    let minStamp = minutes.count > 1 ? minutes : "0" + minutes
    let secStamp = seconds.count > 1 ? seconds : "0" + seconds
    return "\(minStamp) : \(secStamp)"
}
