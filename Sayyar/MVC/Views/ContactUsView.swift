//
//  ContactUsView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 29/06/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import UIKit

struct ContactUsView: View {
    
    @State var reason : String = ""
    @State var description : String = ""
    @State var title : String = ""
    
    @State var tripTitle : String = ""
    
    @State var showHistory = false
    
    @State var showOptions = false
    
    @State var options : [ContactOption] = [
        ContactOption(title: "tech.issue"),
        ContactOption(title: "money.issue"),
        ContactOption(title: "driver"),
        ContactOption(title: "faq.q"),
    ]
    var settings = DataToTransfer()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("send.order")
                .font(.custom("Cairo-SemiBold", size: 18))
                .foregroundColor(gray)
            
            VStack(alignment: .leading, spacing: -11) {
                PurpleSquare(text: $reason, title: "contact.reason".localized)
                    .font(.custom("Cairo-Regular", size: 16))
                    .onTapGesture {
                        withAnimation {
                            self.showOptions.toggle()
                        }
                }
                if showOptions {
                    withAnimation {
                        HStack {
                            List() {
                                ForEach(self.options) { option in
                                    Text(option.title.localized)
                                        .onTapGesture {
                                            self.reason = option.title.localized
                                            withAnimation {
                                                self.showOptions.toggle()
                                            }
                                    }
                                }
                            }
                            .font(.custom("Cairo-Regular", size: 14))
                            
                            Spacer()
                        }
                        .padding(.horizontal, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2))
                                .foregroundColor(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)))
                        )
                    }
                }
            }
            
            
            customTextField(placeholder: "report.title".localized, placename: $title, fieldReq: .constant(false)) {
                
            }
            .font(.custom("Cairo-Regular", size: 15))
            
            
            
            VStack(alignment: .leading, spacing: 0) {
                TextView(text: $description)
                    .frame(height: 150)
                Text("provide.info")
                    .font(.custom("Cairo-Regular", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
            }
            
            
            PurpleSquare(text: $tripTitle, title: "trip".localized)
                .onTapGesture {
                    self.showHistory.toggle()
            }.font(.custom("Cairo-Regular", size: 16))
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    self.showOptions.toggle()
                }
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("send")
                        .font(.custom("Cairo-SemiBold", size: 20))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
            }
            .frame(height: 20, alignment: .center)
            .padding()
            .background(Color(#colorLiteral(red: 0.3450980392, green: 0.2039215686, blue: 0.4470588235, alpha: 1)))
            .cornerRadius(10)
            
            
        }
        .padding()
        .padding(.top)
        .navigationBarTitle("contact.us")
        .sheet(isPresented: self.$showHistory, content: {
            PastOrderSelect(presentPastOrders: self.$showHistory, title: self.$tripTitle).environmentObject(self.settings)
        })
            .onAppear {
                self.tripTitle = self.settings.orderId
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

struct ContactOption : Identifiable {
    var id = UUID()
    var title : String
}
