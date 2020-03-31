//
//  HomeView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import UIKit
import Firebase
import GoogleMaps
import UserNotifications
import SZTextView

let purple = Color("purple")
let lightPurple = Color(#colorLiteral(red: 0.6666666667, green: 0.6235294118, blue: 0.7215686275, alpha: 1))
let dark = Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1))

struct HomeView : View {
    
    @State var rate : Rating = Rating(rawValue: 0)!
    @State var textRating : String = ""
    
    let gmap = MapView()
    let quantity = NumberFormatter.localizedString(from: 1000, number: .decimal)
    let transText = "You have sold %@ apps in %#@months@"
     
    let pathDynamic = GMSMutablePath()
    
    @State var locations: [CLLocationCoordinate2D] = []
    
    @State var showMenu = false
    
    @State var showRating = false
    
    @State var showSearch = false
    
    @State var newFavPlace = false
    
    @State var userId = ""
    
    @State var polyline = GMSPolyline()
    @State var animationPolyline = GMSPolyline()
    @State var path = GMSPath()
    @State var animationPath = GMSMutablePath()
    @State var i: UInt = 0
    
    @State var centerImage : Image = Image("pin")
    
    @State var buttonText = "home.canvas".localized
    
    @State var places : [FavPlace] = [
        FavPlace(name: "home", pType: .home, location: "10mins"),
        FavPlace(name: "work", pType: .work, location: "30mins"),
        FavPlace(name: "meeting", pType: .other, location: "5mins")
    ]
    
    var selectedPlace : FavPlace?
    
    @State var isNewYear : Bool = {
        var myDict: NSDictionary?
        if let path = Bundle.main.url(forResource: "featureflag", withExtension: "plist") {
            
            myDict = NSDictionary(contentsOf: path)
            return myDict?["isNewYear"] as! Bool
        } else {
            return false
        }
    }()
    
    init() {
        
        // 1.
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = .clear
       
        // 2.
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.darkGray,
            .font : UIFont(name:"Cairo-Bold", size: 40)!]

        // 3.
        UINavigationBar.appearance().titleTextAttributes = [
            .font : UIFont(name:"Cairo-Bold", size: 20)!]
        
        //Config.shared.set(defaults: ["buttonText": "Add Pin" as NSObject])
    }
    
    var body: some View {
        
        let drag = DragGesture()
        .onEnded {
            if L102Language.isRTL && $0.translation.width < 100 {
                withAnimation {
                    self.showMenu = false
                }
            } else if $0.translation.width < -100 {
                withAnimation {
                    self.showMenu = false
                }
            }
        }
        
        return NavigationView {
            GeometryReader { geometry in
                
                ZStack {
                    
                    self.gmap
                        .edgesIgnoringSafeArea(.all)
                        .imageScale(.large)
                        .onAppear {
                            self.gmap.map.padding = UIEdgeInsets(top: 20, left: 10, bottom: 240, right: 10)
                    }
                    
                    self.centerImage
                        .foregroundColor(Color.black)
                        .offset(y: (self.locations.count == 2) ? self.gmap.map.center.y - 50 : -10)
                    
                    if self.showRating {
                        RatingView(rate: self.rate, textRating: self.textRating)
                    }
                    DestinationView(places: self.places, addedPin: {
                        self.addPin()
                    }, showSearch: {
                        self.showSearch.toggle()
                    }, newFav: {
                        self.newFavPlace.toggle()
                    })
                }
                    //.offset(x: self.showMenu ? geometry.size.width/1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                
                
                if self.showMenu {
                    Color(#colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0.5))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                    }
                    
                    Sidemenu()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: geometry.size.width/1.5)
                        .transition(.move(edge: .leading))
                }
                
                
            }
            .gesture(drag)
            .navigationBarItems(
                leading:
                
                Button(action: {
                    withAnimation {
                        self.showMenu.toggle()
                    }
                }) {
                    
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(purple)
                        .imageScale(.large)
                        .scaleEffect(CGSize(width: 1.3, height: 1.7))
                }.offset(x: self.showMenu ? UIScreen.main.bounds.width/1.5 : 0))
                .navigationBarTitle(Text(self.showMenu ? "" : "select.from"), displayMode: .inline)
                .accentColor(purple)
                .sheet(isPresented: self.$showSearch, content: {
                    SearchView()
                })
                
        }.sheet(isPresented: self.$newFavPlace, content: {
            NewFavPlaceView()
        })
    }
    
    func addPin() {
        
        let coordinate = gmap.map.projection.coordinate(for: gmap.map.center)
        
        let marker = GMSMarker(position: coordinate)
        marker.iconView?.frame = CGRect(x: 0, y: 0, w: 25, h: 43)
        
        if locations.isEmpty {
            marker.icon = UIImage(named: "pin")?.withTintColor(.green)
        } else if locations.count == 1 {
            marker.icon = UIImage(named: "pin2")?.withTintColor(.red)
        } else if locations.count == 2 {
            self.onFetch()
            return
        }
        
        locations.append(coordinate)
        
        gmap.addMarker(marker: marker)
        //createLocalNotifications()
    }
    
    func onFetch() {
        let place = [Place(lat: locations[1].latitude, lng: locations[1].longitude)]
        let firstPlace = "\(locations.first!.latitude),\(locations.first!.longitude)"

        FetchDirectionsRequest.getDirections(from: firstPlace, destinations: place, completion: ({ path in
            guard let gpath = path else { return }
            self.path = gpath

            self.polyline.path = GMSPolyline.init(path: self.path).path
            self.polyline.strokeWidth = 3
            self.polyline.strokeColor = .black
            self.polyline.map = self.gmap.map

            let bounds = GMSCoordinateBounds.init(path: self.path)
            let update = GMSCameraUpdate.fit(bounds, withPadding: 35)
            self.gmap.map.animate(with: update)

            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                withAnimation {
                    self.animatePolylinePath()
                }
            })
        }))
    }
    
    func animatePolylinePath() {
        
        if (self.i < self.path.count()) {
            self.animationPath.add(self.path.coordinate(at: self.i))
            self.animationPolyline.path = self.animationPath
            self.animationPolyline.strokeColor = .lightGray
            self.animationPolyline.strokeWidth = 3
            self.animationPolyline.map = self.gmap.map
            self.i += 1
        } else {
            
            self.i = 0
            self.animationPath = GMSMutablePath()
            self.animationPolyline.strokeColor = .darkGray
            self.animationPolyline.map = nil
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let supportedLocales: [Locale] = [
            "en",
            "ar",
            ].map(Locale.init(identifier:))
        
        return ForEach(supportedLocales, id: \.identifier) { locale in
            
            ForEach([ColorScheme.dark, .light], id: \.self) { scheme in
                HomeView()
                    .environment(\.locale, locale)
                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
                    .colorScheme(scheme)
            }
        }
        //HomeView()//.previewDevice(PreviewDevice(stringLiteral: "iPhone 8"))
    }
}
