//
//  NotificationView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 01/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    
    @State var notifications : [NotificationData] = [
        NotificationData(title: "Discount for National day 🇸🇦", image: Image("nationalday"), publishedDate: Date()),
        NotificationData(title: "Discount for Ramadan 🌙", image: Image("ramadan"), publishedDate: Date())
    ]
    
    var body: some View {
        
        
        List {
            ForEach(self.notifications) { notification in
                ZStack {
                     NotificationCell(Notification: notification).shadow(radius: 3)
                    NavigationLink(destination: NotificationDetail()) {
                       EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                    
                }
            }
        }
        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
        .navigationBarTitle("Notifications")
    }
    
    init() {
        UITableView.appearance().separatorColor = UIColor.clear
        UITableView.appearance().tableFooterView = UIView()
        
    }
    
}

struct NotificationData : Identifiable {
    var id = UUID()
    
    var title : String
    
    var image : Image
    
    var publishedDate : Date
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

struct NotificationCell : View {
    @State var Notification : NotificationData
    
    var body: some View {
        VStack(spacing: 0) {
            self.Notification.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120, alignment: .center)
                .clipped()
            
            HStack(alignment: .center) {
                Text(self.Notification.title)
                    .font(.custom("Cairo-SemiBold", size: 18))
                Spacer()
                Text(self.Notification.publishedDate.weekday)
                    .font(.custom("Cairo-SemiBold", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
            }.background(Color.white)
            .padding(7)
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(Notification:
            NotificationData(title: "خصم بمناسبة اليوم الوطني", image: Image("sidemenuBg"), publishedDate: Date())
        ).previewLayout(.fixed(width: 350, height: 200))
    }
}
