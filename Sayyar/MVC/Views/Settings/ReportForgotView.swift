//
//  ReportForgotView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 07/05/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct ReportForgotView: View {
    
    @State var selectedOrder : PastOrderData?
    
    @State var selectedDate = Date()
    
    @State var reportTitle : String = ""
    
    @State var reportDetail : String = ""
    var body: some View {
        let now = Date()
        
        return VStack(alignment: .leading, spacing: 10) {
            
            
            Text("Forgot Something in the car")
            .font(.custom("Cairo-Regular", size: 23))
            
            Text("If you forget an item in the partner’s car during your trip, share with us information about the thing you lost so that we can reach the partner soon and better serve you.")
            .font(.custom("Cairo-Regular", size: 15))
            
            Text("Date when you lost the object")
            .font(.custom("Cairo-SemiBold", size: 18))
            
            HStack(spacing: 25) {
                PurpleSquare(text: "Day")
                PurpleSquare(text: "Month")
            }
            .frame(width: 200)
            
            Text("Information about the lost object")
            .font(.custom("Cairo-SemiBold", size: 18))
            
            customTextField(placeholder: "Report Title", placename: $reportTitle, fieldReq: .constant(false)) {
            }
            
            TextView(text: $reportDetail).frame(height: 100)
            
            PurpleSquare(text: "Trip")
            
            Button(action: {
                 
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("send")
                        .font(.custom("Cairo-SemiBold", size: 20))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
            }
            .frame(height: 11, alignment: .center)
            .padding()
            .background(Color(#colorLiteral(red: 0.3450980392, green: 0.2039215686, blue: 0.4470588235, alpha: 1)))
            .cornerRadius(10)
            
            Spacer()
        }.padding()
    }
}

struct PurpleSquare : View {
    
    @State var text : String
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            HStack() {
                Text(text)
                Spacer()
                
                Image(systemName: "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 10, height: 8)
            }
            .frame(height: 44)
            .padding(.horizontal, 10)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(purple, lineWidth: 1)
            )
            
            Text(text)
                .font(.custom("Cairo-Bold", size: 12))
                .foregroundColor(purple)
                .padding(.horizontal ,2)
                .background(Color.white)
                .padding(.leading)
                .padding(.bottom, 45)
            
        }
    }
}

struct ReportForgotView_Previews: PreviewProvider {
    static var previews: some View {
        ReportForgotView()
    }
}
