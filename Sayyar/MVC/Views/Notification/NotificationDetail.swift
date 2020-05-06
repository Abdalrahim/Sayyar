//
//  NotificationDetail.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 12/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct NotificationDetail: View {
    
    var notificationData : NotificationData = NotificationData(title: "Ramadan Offer", image: Image("ramadan"), publishedDate: Date())
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(notificationData.title)
                .font(.custom("Cairo-Bold", size: 18))
            .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
            notificationData.image
                .resizable()
                .frame(height: 200, alignment: .center)
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Image(systemName: "clock.fill")
                Text(notificationData.publishedDate.weekday).font(.custom("Cairo-SemiBold", size: 15))
                Spacer()
            }.foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5333333333, blue: 0.5568627451, alpha: 1)))
            Spacer()
            Text("Ramadan Mubarak. Redeem your Ramadan offer and get 50% discount on every trip.")
                .font(.custom("Cairo-Regular", size: 16))
            
            
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Text("Activate Offer")
                        .font(.custom("Cairo-SemiBold", size: 15))
                        .foregroundColor(.white)
                        .padding()
                        .background(purple)
                        .cornerRadius(10)
                })
                Spacer()
            }
            
            Spacer()
        }
            .padding()
        .background(Color.white).cornerRadius(10)
        .padding()
        .background(Color.init(white: 0.9))
    }
}

struct NotificationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NotificationDetail()
    }
}
