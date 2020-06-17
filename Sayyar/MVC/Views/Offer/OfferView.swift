//
//  OfferView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 01/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//


import SwiftUI
import GoogleMaps
import Pages

struct OfferView: View {
    
    @State var currenOffer : Int = 1
    @State var index: Int = 1
//    var clusterManager     : GMUClusterManager?
    
    @State var offers : [OfferData] = [
        OfferData(
            driverName: "Mohammed",
            rating: 4.5,
            carMake: "Toyota",
            carModel: "Camry",
            carYear: 2019,
            distance: 40.0,
            timeDistance: 25,
            price: 12.5,
            time: 60,
            location : CLLocationCoordinate2D(latitude: 21.542289948557013, longitude: 39.18610509485006)
        ),
        
        OfferData(
            driverName: "Khalid",
            rating: 4.5,
            carMake: "Hyundai",
            carModel: "Elantra",
            carYear: 2020,
            distance: 20.0,
            timeDistance: 5,
            price: 15,
            time: 120,
            location : CLLocationCoordinate2D(latitude: 21.53753967998264, longitude: 39.19593270868063)
        ),
        
        OfferData(
            driverName: "Saleh",
            rating: 4.2,
            carMake: "Hyundai",
            carModel: "Sonata",
            carYear: 2019,
            distance: 50.0,
            timeDistance: 5,
            price: 25,
            time: 200,
            location : CLLocationCoordinate2D(latitude: 21.53703967998265, longitude: 39.19293230868063)
        )
    ]
    
    
    
    let gmap = MapView()
    
    var body: some View {
        ZStack {
            self.gmap
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    self.gmap.map.padding = UIEdgeInsets(top: 20, left: 5, bottom: 200, right: 5)
            }
            VStack {
                Spacer()
                
                VStack(spacing: 10) {
                    scrollbar(selected: self.$index, page: self.offers.count).frame(height: 5)
                    
//                    ModelPages (self.offers, currentPage: $index, hasControl: false) { (pageIndex, offer) in
//                        GeometryReader { geometry in
//                            OfferCard(offer: offer, addOffer: {
//                                print(Double(geometry.frame(in: .global).minX))
//                            })
//                                .rotation3DEffect(Angle(degrees:
//                                    Double((geometry.frame(in: .global).minX) / -20)
//                                ), axis: (x: 10.0, y: 10.0, z: 10.0))
//                                .onAppear {
//                                    self.addPin(offer: offer)
//                                    print(Double(geometry.frame(in: .global).minX))
//                            }
//                            .onTapGesture{
//                                self.currenOffer = pageIndex
//                            }
//                        }.frame(width: UIScreen.main.bounds.width/1.1)
//                    }.accentColor(purple)
                    
                    ScrollView(.horizontal, showsIndicators: false) {

                        HStack{
                            Spacer(minLength: 20)

                            ForEach(0..<self.offers.count) { index in
                                GeometryReader { geometry in
                                    OfferCard(offer: self.offers[index], acceptOffer: {
                                        self.index = index
                                        print(Double(geometry.frame(in: .global).minX), index)
                                    })
                                        .rotation3DEffect(Angle(degrees:
                                            Double((geometry.frame(in: .global).minX) / -20)
                                        ), axis: (x: 10.0, y: 10.0, z: 10.0))
                                        .onAppear {
                                            self.addPin(offer: self.offers[index])
                                            print(Double(geometry.frame(in: .global).minX))
                                            self.index = index
                                    }
                                    .onTapGesture{
                                        self.index = index
                                    }
                                }.frame(width: UIScreen.main.bounds.width/1.1)

                            }
                            Spacer(minLength: 20)
                        }
                    }
                }
                .frame(height:200)
                .padding(.bottom)
            }
            
        }
        .navigationBarTitle(Text("offers.page").foregroundColor(Color.gray), displayMode: .inline)
        
    }
    
    func addPin(offer : OfferData) {
        
        let coordinate = offer.location
        print(coordinate)
        let marker = GMSMarker(position: coordinate)
        
        marker.iconView?.frame = CGRect(x: 0, y: 0, w: 25, h: 43)
        let markerView = UIImageView(image: UIImage(named: "offerPin"))
        
        let price = UILabel(frame: CGRect(x: 2, y: 0, width: 56, height: 60))
        price.text = "\(offer.price) "+"sr"
        price.font = UIFont.init(name: "Cairo-SemiBold", size: 15)
        price.minimumScaleFactor = 0.5
        price.textColor = .white
        price.textAlignment = .center
        price.adjustsFontSizeToFitWidth = true
        
        markerView.addSubview(price)
        marker.iconView = (markerView)
        
        gmap.addMarker(marker: marker)
    }
}
  
struct OfferView_Previews: PreviewProvider {
    
    static var previews: some View {
        let supportedLocales: [Locale] = [
            "en",
            "ar",
            ].map(Locale.init(identifier:))
        
        return ForEach(supportedLocales, id: \.identifier) { locale in
            
            OfferView()
            .environment(\.locale, locale)
            .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
        }
        
    }
}

struct scrollbar: View {
    @Binding var selected : Int
    @State var page : Int
    
    var body: some View {
        HStack {
            ForEach(Range(1...page)) {i in
                Circle().frame(width: 5).foregroundColor((i == self.selected) ? purple : lightPurple)
            }
        }
    }
}
