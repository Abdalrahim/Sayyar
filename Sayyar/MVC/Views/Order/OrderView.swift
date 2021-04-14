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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    let gmap = MapView()
    
    @State var locations: [CLLocationCoordinate2D] = []
    @State var polyline = GMSPolyline()
    @State var animationPolyline = GMSPolyline()
    @State var path = GMSPath()
    @State var animationPath = GMSMutablePath()
    @State var i: UInt = 0
    
    @State var isTaxi = true
    @State var isArriving = true
    @State var showMenu = false
    
    @State var room = ""
    
    var tripEnded: () -> ()
    
    var btnBack : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "line.horizontal.3")
                .foregroundColor(purple)
                .imageScale(.large)
                .scaleEffect(CGSize(width: 1.3, height: 1.7))
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            gmap.padding(.bottom, -20)
                .onAppear {
                    self.gmap.map.padding = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            }.edgesIgnoringSafeArea(.vertical)
            purple
                .overlay(
                    Text("order.ontheway")
                        .font(.custom("Cairo-SemiBold", size: 15))
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
            ).frame(height: 80)
                .cornerRadius(20)
                .padding(.bottom, -50)
            
            VStack(spacing: 15) {
                if isArriving {
                    PartnerArriveView(isTaxi: self.$isTaxi)
                }
                
                HStack(spacing: 15) {
                    Image("destination").padding(.bottom, 17)
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment : .leading, spacing: -5) {
                            Text("from.destination")
                                .font(.custom("Cairo-SemiBold", size: 18))
                            Text("from.rd")
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                        }
                        
                        VStack(alignment: .leading, spacing: -5) {
                            Text("to.destination")
                                .font(.custom("Cairo-SemiBold", size: 18))
                            Text("toroad.rd")
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                        }
                    }
                    
                    Spacer()
                }
                .lineLimit(1)
                .padding(.vertical, -15)
                
                Divider()
                
                if !isArriving {
                    PartnerOnTripView(isTaxi: self.$isTaxi)
                    Divider()
                }
                
                if !isArriving {
                    HStack {
                        Image("safety")
                        Text("safety.procedures")
                            .font(.custom("Cairo-SemiBold", size: 15))
                    }.padding(.vertical, -10)
                    
                    Divider()
                }
                
                Button(action: {
                    self.addPin()
                }, label: {
                    Text("Cancel")
                        .font(.custom("Cairo-SemiBold", size: 16))
                        .foregroundColor(.red)
                }).padding(.vertical, -5)
                
            }
            .padding()
            .background(bgColor)
            .cornerRadius(20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
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
            self.tripEnded()
//            self.onFetch()
            return
        }
        
        locations.append(coordinate)
        
        gmap.addMarker(marker: marker)
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
        OrderView(tripEnded: {
            
        })
    }
}



