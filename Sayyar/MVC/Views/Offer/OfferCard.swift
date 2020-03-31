//
//  OfferCard.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 01/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import GoogleMaps
struct OfferCard: View {
    @State var offer : OfferData
    @State var progressBarValue : CGFloat = 1
    
    @State var currentDate = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var addOffer: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                Image("person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)
                    .cornerRadius(60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 60)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1))
                            .foregroundColor(.gray)
                )
        
                VStack(alignment: .leading) {
                    HStack {
                        Text(offer.driverName)
                            .font(.custom("Cairo-SemiBold", size: 12))
                        
                        Image(systemName: "star.fill")
                            .resizable()
                            .foregroundColor(Color.yellow)
                            .frame(width: 13, height: 13)
                        
                        Text("\(NSNumber(value: offer.rating))")
                            .font(.custom("Cairo-SemiBold", size: 10))
                        
                    }
                    Text("\(offer.carMake) • \(offer.carModel)"+" • \(offer.carYear)")
                        .font(.custom("Cairo-SemiBold", size: 12))
                }
                
                Spacer()
                
                VStack(spacing: 0) {
                    Spacer()
                    Text("timer")
                        .font(.custom("Cairo-SemiBold", size: 10))
                    ProgressCircle(value: self.$progressBarValue)
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
                    
                    
                    Text(String.localizedStringWithFormat("min".localizewithnumber(count: UInt(offer.time))))
                        .font(.custom("Cairo-SemiBold", size: 12))
                }
            }.padding(.horizontal)
            
            Button(action: {
                self.addOffer()
            }, label: {
                Text("accept.offer")
                    .font(.custom("Cairo-SemiBold", size: 12))
                    .foregroundColor(Color.white)
            })
                .padding(20)
                .frame(height : 35)
                .background(purple)
                .cornerRadius(5)
            
        }
        .padding(5)
        .background(Color("bg"))
        .cornerRadius(10)
            .onReceive(timer) { input in
                self.currentDate = input
                withAnimation {
                    if (self.progressBarValue <= 0.9) {
                        self.progressBarValue += 0.1
                    }
                }
            }
        .onAppear{
            self.progressBarValue = self.offer.time/10
        }
    }
}

struct OfferCard_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let offer : OfferData =
        OfferData(
            driverName: "Mohammed",
            rating: 4.5,
            carMake: "Toyota",
            carModel: "Camry",
            carYear: 2019,
            distance: 40.0,
            timeDistance: 25,
            price: 12.5,
            time: 1,
            location : CLLocationCoordinate2D(latitude: 21.542289948557013, longitude: 39.18610509485006)
        )
        let supportedLocales: [Locale] = [
            "en",
            "ar",
            ].map(Locale.init(identifier:))
        
        return ForEach(supportedLocales, id: \.identifier) { locale in
            
            ForEach([ColorScheme.dark, .light], id: \.self) { scheme in
                OfferCard(offer: offer, addOffer: {
                    
                })
                    .environment(\.locale, locale)
                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
                    .colorScheme(scheme)
                    .previewLayout(.fixed(width: 300, height: 200))
            }
        }
        
    }
}
