//
//  OrderView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 19/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleMaps

struct OrderView: View {
    let gmap = MapView()
    
    @State var locations: [CLLocationCoordinate2D] = []
    @State var polyline = GMSPolyline()
    @State var animationPolyline = GMSPolyline()
    @State var path = GMSPath()
    @State var animationPath = GMSMutablePath()
    @State var i: UInt = 0
    
    @State var isTaxi = true
    
    @State var room = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                gmap.padding(.bottom, -20)
                    .onAppear {
                        self.gmap.map.padding = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
                }
                purple
                    .overlay(
                        Text("waiting driver")
                            .font(.custom("Cairo-SemiBold", size: 15))
                            .foregroundColor(.white)
                            .padding(.bottom, 40)
                ).frame(height: 80)
                    .cornerRadius(20)
                    .padding(.bottom, -50)
                 
                VStack {
                    HStack(alignment : .center) {
                        Image(systemName: "phone.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                            .padding(6)
                            .overlay(
                                Circle()
                                    .stroke(Color.init(white: 0.8), lineWidth: 1)
                        )
                        
                        Image("person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(40)
                            .padding(.horizontal)
                        
                        ///##Chat Room Bugs Canvas
//                        NavigationLink(destination: ChatView(room: TextNetworkManager(room: room))) {
//                            Image(systemName: "text.bubble.fill")
//                                .resizable()
//                                .frame(width: 15, height: 15)
//                                .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
//                                .padding(6)
//                            .overlay(
//                                    Circle()
//                                        .stroke(Color.init(white: 0.8), lineWidth: 1)
//                            )
//                        }
                        
                        
                    }
                    HStack {
                        Text("Mohammed")
                            .font(.custom("Cairo-SemiBold", size: 15))
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4.9")
                            .font(.custom("Cairo-SemiBold", size: 13))
                    }.padding(.vertical, -10)
                    Text("5152 AK")
                        .font(.custom("Cairo-Bold", size: 15)).padding(.horizontal, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.init(white: 0.8), lineWidth: 1)
                    )
                    
                    HStack(spacing: 4) {
                        Text("Toyota").font(.custom("Cairo-SemiBold", size: 15))
                        Text("•").font(.custom("Cairo-SemiBold", size: 15))
                        Text("Camry").font(.custom("Cairo-SemiBold", size: 15))
                        Text("•").font(.custom("Cairo-SemiBold", size: 15))
                        Text("2020").font(.custom("Cairo-SemiBold", size: 15))
                        
                        if isTaxi {
                            Image("taxi-sign")
                        }
                    }.padding(.vertical, -15)
                    
                    Divider()
                    
                    HStack {
                        Image("destination")
                        VStack(spacing: 20) {
                            VStack(alignment : .leading) {
                                Text("from destination")
                                    .font(.custom("Cairo-SemiBold", size: 16))
                                Text("Azizyah rd")
                                    .font(.custom("Cairo-SemiBold", size: 15))
                                    .foregroundColor(.gray)
                            }.padding(.vertical, -5)
                            
                            VStack(alignment : .leading) {
                                Text("from destination")
                                    .font(.custom("Cairo-SemiBold", size: 16))
                                Text("Azizyah rd")
                                    .font(.custom("Cairo-SemiBold", size: 15))
                                    .foregroundColor(.gray)
                            }.padding(.vertical, -5)
                        }
                        
                        Spacer()
                    }.padding(.vertical, -5)
                    
                    Divider()
                    
                    Button(action: {
                        self.addPin()
                    }, label: {
                        Text("Cancel")
                            .font(.custom("Cairo-SemiBold", size: 16))
                            .foregroundColor(.red)
                    }).padding(.vertical, -5)
                    
                }
                .padding()
                .background(Color("bg"))
                .cornerRadius(20)
            }
            .edgesIgnoringSafeArea(.all)
        }.onDisappear {
            
        }
    }
    
    func addPin() {
        
        let coordinate = gmap.map.projection.coordinate(for: gmap.map.center)
        
        let marker = GMSMarker(position: coordinate)
        marker.iconView?.frame = CGRect(x: 0, y: 0, w: 25, h: 43)
        
        if locations.isEmpty {
            marker.icon = UIImage(named: "fromPin")?.withTintColor(.green)
        } else if locations.count == 1 {
            marker.icon = UIImage(named: "toPin")?.withTintColor(.red)
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

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
