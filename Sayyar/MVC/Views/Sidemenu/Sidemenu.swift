//
//  Sidemenu.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Firebase

struct Sidemenu: View {
    
    let db = Firestore.firestore()
    
    @State var isArabic : Bool = false
    
    @State var loginText : String = {
        if Auth.auth().currentUser != nil{
            return "Hello Anon"
        } else {
            return "Login"
        }
    }()
    
    @State var image : Image = {
        if Auth.auth().currentUser != nil {
            return Image(systemName: "person.fill")
        } else {
            return Image(systemName: "person")
        }
    }()
    
    
    var body: some View {
        
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        Image("sidemenuBg")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY/9)
                            .clipped()
                    } else {
                        Image("sidemenuBg")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }.frame(height: UIDevice.isSmallScreen() ? 200 : 250)
            
            
            VStack(alignment: .leading, spacing : UIDevice.isSmallScreen() ? -2.0 : 0.0) {
                
                HStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 0) {
                        Image("person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .overlay(
                                RoundedRectangle(cornerRadius: 60)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1))
                                    .foregroundColor(.white)
                        ).cornerRadius(30)
                        
                        Text("Abdullah Mohammed")
                            .font(.custom("Cairo-Bold", size: 20))
                            .lineLimit(1)
                            .foregroundColor(.white)
                        
                        HStack {
                            Image("wallet")
                                .foregroundColor(.white)
                                .imageScale(.large)
                            
                            Text("\(NSNumber(value: 25)) SR")
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(.white)
                        }
                    }.padding(.top, UIDevice.isSmallScreen() ? -150 : -200)
                    Spacer()
                }
                
                
                NavigationLink(destination: NotificationView()) {
                    SideMenuButton(image: Image(systemName: "bell.fill"), text: "notifications")
                }.padding()
                
                NavigationLink(destination: PastOrdersView()) {
                    SideMenuButton(image: Image("trip log"), text: "trip.log")
                }.padding()
                
                NavigationLink(destination: OrderView()) {
                    SideMenuButton(image: Image(systemName: "creditcard.fill"), text: "payment.method")
                }.padding()
                
                NavigationLink(destination: SupportView()) {
                    SideMenuButton(image: Image(systemName: "questionmark.circle.fill"), text: "help")
                }.padding()
                
                NavigationLink(destination: Settings()) {
                    SideMenuButton(image: Image(systemName: "bubble.left.and.bubble.right.fill"), text: "contact.us")
                }.padding()
                
                NavigationLink(destination: Settings()) {
                    SideMenuButton(image: Image("settings"), text: "settings")
                }.padding()
                
                Spacer(minLength: UIDevice.isSmallScreen() ? 20 : 40)
                
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        if Auth.auth().currentUser == nil {
                            self.loginAnon()
                        }
                    }) {
                        
                        Text("join.us")
                            .foregroundColor(.white)
                            .font(.custom("Cairo-SemiBold", size: 14))
                    }
                    .frame(width: 140, height: 40, alignment: .center)
                    .background(Color(#colorLiteral(red: 0.3450980392, green: 0.2039215686, blue: 0.4470588235, alpha: 1)))
                    .cornerRadius(17)
                    Spacer()
                }
                Spacer()
                
            }
            
        }.background(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)))
            
            .onAppear(){
                print(UIDevice.isSmallScreen())
        }
    }
    
    func loginAnon() {
        Auth.auth().signInAnonymously() { (authResult, authError) in
            
            if let erorr = authError {
                debugPrint(erorr.localizedDescription)
            } else if let user = authResult?.user {
                
                let isAnonymous = user.isAnonymous  // true
                let uid = user.uid
                print(isAnonymous, uid)
                
                self.loginText = "Hello Anon"
                
                let userjson : [String : Any] =
                    [
                        "result" :[
                            [
                                "user": [
                                    "userId" : uid
                                ]
                            ]
                        ]
                ]
                
                UserSingleton.shared.loggedInUser = UserModel(JSON: userjson)
                
                self.addUserwith(id : uid)
                
            }
        }
    }
    
    func addUserwith(id : String){
        self.db.collection("users").document(id).setData([:]) { error in
            if let err = error {
                debugPrint("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}



struct MenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        Sidemenu()
    }
}



struct SideMenuButton: View {
    
    @State var image : Image
    
    @State var text : String
    
    var body: some View {
        HStack {
            image
                .foregroundColor(Color(#colorLiteral(red: 0.4274509804, green: 0.4274509804, blue: 0.4274509804, alpha: 1)))
                .imageScale(.large)
                .frame(width: 20)
            
            Text(text.localise)
                .foregroundColor(.black)
                .font(.custom("Cairo-SemiBold", size: 18))
                .padding(.horizontal)
        }
    }
}
