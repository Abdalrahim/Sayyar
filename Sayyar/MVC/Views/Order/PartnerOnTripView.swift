//
//  PartnerOnTripView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 14/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct PartnerOnTripView: View {
    @Binding var isTaxi : Bool
    var body: some View {
        HStack {
            Image("person")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(40)
            VStack(alignment:.leading, spacing:0) {
                HStack {
                    Text("Mohammed")
                        .font(.custom("Cairo-SemiBold", size: 15))
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("4.9")
                        .font(.custom("Cairo-SemiBold", size: 13))
                }
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
                }
            }
            Spacer()
            VStack(spacing: 20){
                Image(systemName: "phone.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                    .padding(6)
                NavigationLink(destination: Settings()) {
                    Image(systemName: "text.bubble.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(6)
                }
            }.padding(.vertical, 5)
        }.padding(.vertical, -10)
    }
}

struct PartnerOnTripView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerOnTripView(isTaxi: .constant(true)).previewLayout(.fixed(width: 400, height: 150))
    }
}
