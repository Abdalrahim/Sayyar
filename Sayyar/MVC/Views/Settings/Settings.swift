
//
//  Settings.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 25/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @State var data = CustomRowModel(firstName: "Sam", lastName: "Black", phoneNumber: 533691336, email: "samblack@gamil.com", image: Image("person"), isExpanded: false)
    
    @State var places : [FavPlace] = [
        FavPlace(name: "home", pType: .home, location: "10mins"),
        FavPlace(name: "work", pType: .work, location: "30mins"),
        FavPlace(name: "meeting", pType: .other, location: "5mins")
    ]
    
    
    @State var firstName: String = ""
    
    @State var lastName: String = ""
    
    var body: some View {
        
        return ScrollView {
            VStack(alignment: .center, spacing: 25) {
                Image("person")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(40)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("account.info")
                    .font(.custom("Cairo-SemiBold", size: 16))
                    CustomRow(model: self.data, firstName: $firstName, lastName: $lastName)
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text("fav.place")
                        .font(.custom("Cairo-SemiBold", size: 16))
                    
                    ForEach(self.places) {place in
                        FavPlaceSettingRow(favPlace: place)
                    }
                }
                
                HStack(alignment: .bottom) {
                    
                    Text("Logout")
                        .font(.custom("Cairo-SemiBold", size: 16))
                        .padding(.leading)
                    
                    
                    Spacer()
                }
                .frame(height: 44)
                .background(Color.init(white: 0.95))
                .cornerRadius(5)
            }.padding()
        }
        .navigationBarTitle("settings")
        .onAppear {
            self.firstName = self.data.firstName
            
            self.lastName = self.data.lastName
            
        }
    }
}

struct CustomRow: View {
    
    @State var model : CustomRowModel
    
    @Binding var firstName: String
    
    @Binding var lastName: String
    
    var body: some View {
        let quantity = NumberFormatter.localizedString(from: NSNumber(value: model.phoneNumber), number: .none)
        let phonetext = String.localizedStringWithFormat(quantity)
        
        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                
                Text("first.name")
                    .font(.custom("Cairo-SemiBold", size: 16))
                    .padding(.leading)
                
                TextField(model.firstName.isEmpty ? "first.name" : model.firstName, text: $firstName)
                    .font(.custom("Cairo-SemiBold", size: 15))
                
            }
            .frame(height: 44)
            .background(Color.init(white: 0.95))
            .cornerRadius(5)
            
            HStack {
                
                Text("last.name")
                    .font(.custom("Cairo-SemiBold", size: 16))
                    .padding(.leading)
                
                TextField(model.lastName.isEmpty ? "last.name" : model.lastName, text: $lastName)
                    .font(.custom("Cairo-SemiBold", size: 15))
                
                Spacer()
                
            }
            .frame(height: 44)
            .background(Color.init(white: 0.95))
            .cornerRadius(5)
            
            HStack {
                
                Text("phone.number")
                    .font(.custom("Cairo-SemiBold", size: 16))
                    .padding(.leading)
                
                Text(phonetext)
                    .font(.custom("Cairo-SemiBold", size: 15))
                
                Spacer()
                
            }
            .frame(height: 44)
            .background(Color.init(white: 0.95))
            .cornerRadius(5)
            
            HStack {
                
                Text("Email")
                    .font(.custom("Cairo-SemiBold", size: 16))
                    .padding(.leading)
                
                Text(model.email)
                    .font(.custom("Cairo-SemiBold", size: 15))
                
                Spacer()
                
            }
            .frame(height: 44)
            .background(Color.init(white: 0.95))
            .cornerRadius(5)
            
        }
        .background(bgColor)
        .cornerRadius(5)
        .animation(.easeIn)
        .onTapGesture {
            self.model.isExpanded.toggle()
        }
    }
}


struct FavPlaceSettingRow : View {
    @State var favPlace : FavPlace
    
    var image : Image {
        switch favPlace.pType {
        case .home:
            return Image("homeSettings")
        case .work:
            return Image("workSettings")
        case .place:
            return Image("favSettings")
        case .other:
            return Image("favSettings")
        case .add:
            return Image(systemName: "plus.circle.fill")
        }
    }
    var body: some View {
        HStack {
            
            Text(favPlace.name)
                .font(.custom("Cairo-SemiBold", size: 16))
                .padding(.leading)
            Spacer()
            
            self.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 25, height: 25)
                .padding(.trailing)
            
        }
        .frame(height: 44)
        .background(Color.init(white: 0.95))
        .cornerRadius(5)
    }
}
struct CustomRowModel: Identifiable {
    let id = UUID().uuidString
    let firstName : String
    let lastName : String
    let phoneNumber : Int
    let email: String
    let image : Image?
    var isExpanded : Bool
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}

