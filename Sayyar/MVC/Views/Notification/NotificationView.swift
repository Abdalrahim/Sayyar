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
        NotificationData(title: "sa", image: Image("person"), publishedDate: Date())
    ]
    
    var body: some View {
        List(notifications) { notifi in
            Text(notifi.title)
        }
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
