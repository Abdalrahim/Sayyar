//
//  PartnerArriveView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 14/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct PartnerArriveView: View {
    @Binding var isTaxi : Bool
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment : .center) {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(6)
                        .overlay(
                            Circle()
                                .stroke(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1)
                    )
                    
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)
                        .padding(.horizontal)
                    
                    ///##Chat Room Bugs Canvas
                    NavigationLink(destination: ChatView(room: TextNetworkManager(room: "Terataxi Dev Room"))) {
                        Image(systemName: "text.bubble.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                            .padding(6)
                            .overlay(
                                Circle()
                                    .stroke(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1)
                        )
                    }
                    
                    
            }
        
            HStack {
                Text("Mohammed")
                    .font(.custom("Cairo-SemiBold", size: 15))
                
                Image(systemName: "star.fill")
                    .resizable().frame(width: 13, height: 13)
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
            }.padding(.vertical, -10)
            
            Divider()
        }
    }
}

struct PartnerArriveView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerArriveView(isTaxi: .constant(true)).previewLayout(.fixed(width: 300, height: 200))
    }
}
