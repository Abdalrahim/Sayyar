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
    
    @State var placename : String = ""
    
    @State var showTypeList : Bool = false
    
    @State var showDetail : Bool = false
    
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
                    .background(Color("bg"))
                }
                .frame(height: 200, alignment: .center)
                .cornerRadius(10)
                .shadow(radius: 1)
                
                
                HStack {
                    customTextField(placeholder: "place.name", placename: self.$placename) {
                        
                    }
                    ZStack(alignment: .trailing) {
                        customTextField(placeholder: "type", placename: self.$placename) {}
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
                        customTextField(placeholder: "place.details", placename: self.$placename) {
                            
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

struct customTextField: View {
    
    @State var placeholder : String
    
    @State var textFieldActive : Bool = false
    @Binding var placename : String
    
    var commit: () -> ()
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            
            TextField(placeholder, text: $placename, onEditingChanged: {edited in
                withAnimation {
                    self.textFieldActive = edited
                }
            }, onCommit: {
                self.commit()
            }).frame(height: 44).padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(textFieldActive ? purple : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1)
            )
            
            if textFieldActive {
                Text(placeholder)
                    .font(.custom("Cairo-Bold", size: 12))
                    .foregroundColor(purple)
                    .padding(2)
                    .background(Color.white)
                    .padding(.leading)
                    .padding(.bottom, 45)
                    .animation(.easeIn)
                    .transition(.move(edge: .bottom))
            }
        }
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
