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
            time: 1,
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
            time: 5,
            location : CLLocationCoordinate2D(latitude: 21.53753967998264, longitude: 39.19593270868063)
        )
    ]
    
    let gmap = MapView()
    
    var body: some View {
        NavigationView {
            
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
                        
                        ModelPages (self.offers, currentPage: $index, hasControl: false) { (pageIndex, offer) in
                            GeometryReader { geometry in
                                OfferCard(offer: offer, addOffer: {
                                    print(Double(geometry.frame(in: .global).minX))
                                    })
                                    .rotation3DEffect(Angle(degrees:
                                        Double((geometry.frame(in: .global).minX) / -20)
                                    ), axis: (x: 10.0, y: 10.0, z: 10.0))
                                    .onAppear {
                                        self.addPin(offer: offer)
                                        print(Double(geometry.frame(in: .global).minX))
                                }
                                .onTapGesture{
                                    //self.currenOffer = offer
                                }
                            }.frame(width: UIScreen.main.bounds.width/1.1)
                        }
                        
//                        ScrollView(.horizontal, showsIndicators: false) {
//
//                            HStack{
//                                Spacer(minLength: 20)
//
//                                ForEach(self.offers) { offer in
//                                    GeometryReader { geometry in
//                                        OfferCard(offer: offer, addOffer: {
//                                            print(Double(geometry.frame(in: .global).minX))
//                                            })
//                                            .rotation3DEffect(Angle(degrees:
//                                                Double((geometry.frame(in: .global).minX) / -20)
//                                            ), axis: (x: 10.0, y: 10.0, z: 10.0))
//                                            .onAppear {
//                                                self.addPin(offer: offer)
//                                                print(Double(geometry.frame(in: .global).minX))
//                                        }
//                                        .onTapGesture{
//                                            //self.currenOffer = offer
//                                        }
//                                    }.frame(width: UIScreen.main.bounds.width/1.1)
//
//                                }
//                                Spacer(minLength: 20)
//                            }
//                        }
                    }
                    .frame(height:200)
                    .padding(.bottom)
                }
                
            }
            .navigationBarTitle(Text("offers.page").foregroundColor(Color.gray), displayMode: .inline)
        }
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

struct ProgressCircle: View {
    
    @Binding var value:CGFloat
    
    @State var minute : Int = 0
    @State var second : Int = 60
    
    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .global)
        return frame.size.width * value
    }
    
    func getPercentage(_ value:CGFloat) -> String {
        let intValue = Int(ceil(value * 100))
        return "\(intValue) %"
    }
    
    func getime(_ value:CGFloat) -> String {
        let intValue = (second - Int(value * 10))
//        print(value)
        
        return "\(minute) : \(intValue)"
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray, style:
                    StrokeStyle(
                        lineWidth: 3,
                        lineCap: .butt,
                        dash: [2,3]))
                .frame(width: 45)
            
            Circle()
                .trim(from: value, to: 1)
                .stroke(purple,
                        style: StrokeStyle(
                            lineWidth: 3,
                            lineCap: .butt))
                .frame(width:45)
                .rotationEffect(Angle(degrees:-90))
            
            Text(getime(value))
                .font(.custom("Cairo-Bold", size: 11))
                .foregroundColor(purple)
        }
    }
}
