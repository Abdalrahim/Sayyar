//
//  NewFavPlaceView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 18/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct NewFavPlaceView : View {
    
    let gmap = MapView()
    
    @State var placeName : String = ""
    
    @State var placetype : favPlacetype?
    
    @State var placeDetails : String = ""
    
    @State var placeTitle : String = "Loading.."
    
    @State var placeSubtitle : String = "Loading.."
    
    @State var showTypeList : Bool = false
    
    @State var showDetail : Bool = false
    
    @State var fieldRed : Bool = false
    
    var coordination : CLLocationCoordinate2D
    
    var placeTypeName : String {
        switch self.placetype {
        case .home:
            return "Home"
        case .work:
            return "Work"
        case .place:
            return "Other"
        default:
            return "Other"
        }
    }
    
    func googleMapsiOSSDKReverseGeocoding(completion : @escaping (_ address: GMSAddress?) -> Void ) {
        GMSServices.provideAPIKey(GMSApiKey)
        let aGMSGeocoder: GMSGeocoder = GMSGeocoder()
        aGMSGeocoder.reverseGeocodeCoordinate(self.coordination) { (GeocodeResponse, error) in
            if error != nil {
                print(error.debugDescription)
                return
            } else {
                
            }
            guard let gmsAddress: GMSAddress = GeocodeResponse?.firstResult() else {
                return
            }
            completion(gmsAddress)
        }
        
    }
    
    var body: some View {
        self.googleMapsiOSSDKReverseGeocoding { (address) in
            if let thoroughfare = address?.thoroughfare {
                 self.placeTitle = thoroughfare
            }
            if let subLocality = address?.subLocality {
                self.placeSubtitle = subLocality
            }
        }
        
       return GeometryReader { geometry in
            VStack(spacing: 35) {
                Text("save.location")
                .font(.custom("Cairo-SemiBold", size: 23))
                
                ZStack(alignment: .bottomLeading) {
                    self.gmap//.padding(.bottom, 60)
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text(self.placeTitle)
                                .font(.custom("Cairo-SemiBold", size: 15))
                            Text(self.placeSubtitle)
                                .font(.custom("Cairo-SemiBold", size: 14)).foregroundColor(.gray)
                        }.padding(.leading, 30)
                        
                        Spacer()
                    }
                .frame(height: 60)
                    .background(bgColor)
                }
                .frame(height: 200, alignment: .center)
                .cornerRadius(10)
                .shadow(radius: 1)
                
                
                HStack {
                    customTextField(placeholder: "place.name", placename: self.$placeName, fieldReq: self.$fieldRed) {
                        
                    }
                    ZStack(alignment: .trailing) {
                        HStack {
                            Text(self.placetype == nil ? "type" : self.placeTypeName)
                                .disabled(true)
                                .padding(.leading)
                            Spacer()
                            Image(systemName: self.placetype == nil ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .padding(.trailing)
                            
                        }.foregroundColor(self.placetype == nil ? Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)) : purple)
                            .frame(width: 120, height: 44)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(self.placetype == nil ? Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)) : purple, lineWidth: 1)
                        )
                            .onTapGesture {
                                self.showTypeList.toggle()
                        }
                        if self.showTypeList {
                            VStack(spacing: 20) {
                                TypeView(placeType: favPlacetype(rawValue: 0)!)
                                    .onTapGesture {
                                        self.placetype = favPlacetype(rawValue: 0)!
                                        self.showTypeList = false
                                }
                                TypeView(placeType: favPlacetype(rawValue: 1)!)
                                    .onTapGesture {
                                        self.placetype = favPlacetype(rawValue: 1)!
                                        self.showTypeList = false
                                }
                                
                                TypeView(placeType: favPlacetype(rawValue: 2)!)
                                    .onTapGesture {
                                        self.placetype = favPlacetype(rawValue: 2)!
                                        self.showTypeList = false
                                }
                            }
                            .padding(10)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(purple, lineWidth: 1))
                        }
                    }
                }
                
                ZStack(alignment: .trailing) {
                    if self.showDetail {
                        customTextField(placeholder: "place.details", placename: self.$placeDetails, fieldReq: .constant(true)) {
                            
                        }
                        
                    } else {
                        Button(action: {
                            self.showDetail.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                Text("add.detail")
                            }.foregroundColor(purple)
                        })
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("")
                }, label: {
                    Spacer()
                    Text("save.location")
                        .foregroundColor(.white)
                    .font(.custom("Cairo-SemiBold", size: 15))
                    Spacer()
                })
                    .buttonStyle(BorderlessButtonStyle())
                .frame(height: 45)
                .background(purple)
                .cornerRadius(10)
                
            }.padding(30)
        }
    }
}
//
struct NewFavPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NewFavPlaceView(coordination:
            CLLocationCoordinate2D(latitude: 21.550270436442297, longitude: 39.18819688260556)
        )
    }
}

//21.550270436442297
//39.18819688260556

struct TypeView: View {
    
    var placeType : favPlacetype
    
    var image : Image {
        switch placeType {
        case .home:
            return Image("homeSettings")
        case .work:
            return Image("workSettings")
        case .place:
            return Image("favSettings")
        default:
            return Image("favSettings")
        }
    }
    
    var name : String {
        switch placeType {
        case .home:
            return "Home"
        case .work:
            return "Work"
        case .place:
            return "Other"
        default:
            return "Other"
        }
    }
     
    var body: some View {
        HStack(alignment: .center) {
            Text(name)
            Spacer()
            image.resizable().frame(width: 20, height: 20)
        }.frame(width: 100)
    }
}
