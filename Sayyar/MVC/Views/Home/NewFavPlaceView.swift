//
//  NewFavPlaceView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 18/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
//TextFieldEffects

struct NewFavPlaceView : View {
    
    let gmap = MapView()
    
    @State var placeName : String = ""
    
    @State var placeDetails : String = ""
    
    @State var showTypeList : Bool = false
    
    @State var showDetail : Bool = false
    
//    var place : FavPlace = FavPlace(name: <#T##String#>, pType: <#T##type#>, location: <#T##String#>)
    
    var body: some View {
        
       GeometryReader { geometry in
            VStack(spacing: 35) {
                Text("new.place")
                .font(.custom("Cairo-SemiBold", size: 25))
                
                ZStack(alignment: .bottomLeading) {
                    self.gmap.padding(.bottom, 60)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Office")
                                .font(.custom("Cairo-SemiBold", size: 15))
                            Text("Office")
                                .font(.custom("Cairo-SemiBold", size: 14)).foregroundColor(.gray)
                        }
                        .frame(height: 20)
                        
                        Spacer()
                    }
                    .padding(20)
                    .background(bgColor)
                }
                .frame(height: 200, alignment: .center)
                .cornerRadius(10)
                .shadow(radius: 1)
                
                
                HStack {
                    customTextField(placeholder: "place.name", placename: self.$placeName) {
                        
                    }
                    ZStack(alignment: .trailing) {
                        customTextField(placeholder: "type", placename: self.$placeName) {}
                            .disabled(true)
                            .frame(width: 120)
                            .onTapGesture {
                                self.showTypeList.toggle()
                        }
                        .overlay(
                            VStack(spacing: 20) {
                                TypeView(placeType: type(rawValue: 0)!)
                                TypeView(placeType: type(rawValue: 1)!)
                                TypeView(placeType: type(rawValue: 2)!)
                            }
                            .padding(10)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(purple, lineWidth: 1))
                                .padding(.top, 78)
                        )
                    }
                }
                
                ZStack(alignment: .trailing) {
                    if self.showDetail {
                        customTextField(placeholder: "place.details", placename: self.$placeDetails) {
                            
                        }
                        
                    } else {
                        Button(action: {
                            self.showDetail.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Image(systemName: "plus")
                                Text("add detail")
                            }.foregroundColor(purple)
                        })
                    }
                }
                
                Spacer()
                
                Button(action: {
                    print("")
                }, label: {
                    Spacer()
                    Text("Save Location")
                        .foregroundColor(.white)
                    .font(.custom("Cairo-SemiBold", size: 15))
                    Spacer()
                })
                    .buttonStyle(BorderlessButtonStyle())
                .frame(height: 45)
                .background(purple)
                .cornerRadius(10)
                
            }.padding(.horizontal, 30)
        }
    }
    
}

struct NewFavPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        NewFavPlaceView()
    }
}


struct TypeView: View {
    
    var placeType : type
    
    var image : Image {
        switch placeType {
        case .home:
            return Image("home")
        case .work:
            return Image("work")
        case .place:
            return Image("fav")
        default:
            return Image("fav")
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
        HStack {
            Text(name)
            Spacer()
            image.resizable().frame(width: 20, height: 20)
        }
    }
}
