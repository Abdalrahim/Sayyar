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

var offers : [OfferData] = [
    OfferData(
        id: 0,
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
        show : false
    ),
    
    OfferData(
        id: 1,
        driverName: "Khalid",
        rating: 4.5,
        carMake: "Hyundai",
        carModel: "Elantra",
        carYear: 2020,
        distance: 20.0,
        timeDistance: 5,
        price: 15,
        time: 120,
        location : CLLocationCoordinate2D(latitude: 21.53753967998264, longitude: 39.19593270868063),
        show : false
    ),
    
    OfferData(
        id: 2,
        driverName: "Saleh",
        rating: 4.2,
        carMake: "Hyundai",
        carModel: "Sonata",
        carYear: 2019,
        distance: 50.0,
        timeDistance: 5,
        price: 25,
        time: 200,
        location : CLLocationCoordinate2D(latitude: 21.53703967998265, longitude: 39.19293230868063),
        show : false
    ),
    
    OfferData(
        id: 3,
        driverName: "Saleh",
        rating: 4.2,
        carMake: "Hyundai",
        carModel: "Sonata",
        carYear: 2019,
        distance: 50.0,
        timeDistance: 5,
        price: 25,
        time: 200,
        location : CLLocationCoordinate2D(latitude: 21.53703967998265, longitude: 39.19293230868063),
        show : false
    )
]

struct OfferView: View {
    
    @State var currenOffer : Int = 1
    @State var index: Int = 0
    
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var op : CGFloat = 0
//    var clusterManager     : GMUClusterManager?
    var tripEnded: () -> ()
    let gmap = MapView()
    
    var body: some View {
        ZStack {
            self.gmap
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    self.gmap.map.padding = UIEdgeInsets(top: 20, left: 5, bottom: 250, right: 5)
            }
            VStack(spacing: 10) {
                Spacer()
                
                VStack(spacing: 10) {
                scrollbar(selected: self.$index, page: offers.count).frame(height: 5)
                    
                    Carousel(width: UIScreen.main.bounds.width, page: self.$index, height: 250, count: offers.count, tripEnded: {
                        self.tripEnded()
                    })
                
                }
                .frame(height: 250)
            }
            .animation(.spring()).padding(.bottom)
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
            
            OfferView(tripEnded: {})
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
                Circle().frame(width: 5).foregroundColor((i - 1 == self.selected) ? purple : lightPurple)
            }
        }
    }
}

struct Listing : View {
    
    @Binding var page : Int
    
    var tripEnded: () -> ()
    var body: some View{
        
        HStack(spacing: 0){
            
            ForEach(offers){i in
                OfferCard(offer: i, page: self.$page, tripEnded: {
                    self.tripEnded()
                }, width: UIScreen.main.bounds.width)
            }
        }
    }
}
