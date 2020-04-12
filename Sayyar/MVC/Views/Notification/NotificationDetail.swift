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
            Text(notificationData.title).font(.custom("Cairo-Bold", size: 18))
            notificationData.image
                .resizable()
                .frame(height: 200, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .padding()
            
            HStack {
                Image(systemName: "clock.fill")
                Text(notificationData.publishedDate.weekday).font(.custom("Cairo-SemiBold", size: 15))
                Spacer()
            }
            Spacer()
            Text("Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In. Ramadan Offers All In.")
                .font(.custom("Cairo-Regular", size: 18))
            
            
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
    .navigationBarTitle("Notifications")
        
    }
}

struct NotificationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NotificationDetail()
    }
}
