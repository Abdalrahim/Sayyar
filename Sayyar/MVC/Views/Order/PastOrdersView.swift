//
//  PastOrdersView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 14/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct PastOrdersView: View {
    
    @State var pastOrders : [PastOrderData] = [
        PastOrderData(
            status: OrderStatus(rawValue: 0)!,
            driverName: "Mohammed",
            price: 100,
            time: Date(),
            fromPlace: "Rehab school",
            toPlace: "Saleh Road",
            rating: 4)
    ]
    
    var body: some View {
        VStack {
            List(pastOrders) { order in
                PastOrderCell(pastOrder: order)
                    .shadow(radius: 4)
                
            }.background(Color(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)))
        }
        .navigationBarTitle("past trips")
    }
    
    init() {
        UITableView.appearance().separatorColor = UIColor.clear
        UITableView.appearance().tableFooterView = UIView()
        
    }
}

struct PastOrderCell : View {
    
    @State var pastOrder : PastOrderData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(getDate(format: "d MMMM , hh:mm a", date: pastOrder.time))
                        .font(.custom("Cairo-SemiBold", size: 16))
                    HStack {
                        RatePicker(rate: .constant(Rating(rawValue: pastOrder.rating)!), size: 10)
                        Text(pastOrder.driverName)
                            .font(.custom("Cairo-Regular", size: 15))
                    }
                }
                Spacer()
                
                VStack(alignment: .center, spacing: 0) {
                    Text("\(pastOrder.price) S.R").font(.custom("Cairo-SemiBold", size: 16))
                    Text(pastOrder.status.desc()).font(.custom("Cairo-Regular", size: 15))
                }.foregroundColor((pastOrder.status.rawValue == 2) ? red : .black)
            }
            Divider()
            HStack(alignment: .center, spacing: 15) {
                VStack(alignment: .center, spacing: 0) {
                    Image("pastfrompin")
                    Line(height: 30)
                        .stroke(
                            Color(#colorLiteral(red: 0.6391561627, green: 0.6392526031, blue: 0.6391438842, alpha: 1)),
                            style:
                            StrokeStyle(
                                lineWidth: 1,
                                lineCap: .butt,
                                dash: [3]
                            )
                    ).frame(width : 1, height: 30)
                    Image("pasttopin")
                }
                VStack(alignment: .leading, spacing: 20) {
                    Text(pastOrder.fromPlace)
                        .lineLimit(1)
                        .font(.custom("Cairo-SemiBold", size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1)))
                    
                    Text(pastOrder.toPlace)
                        .lineLimit(1)
                        .font(.custom("Cairo-SemiBold", size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1)))
                    
                }.padding(.top , 0)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct PastOrderCell_Previews: PreviewProvider {
    static var previews: some View {
        PastOrderCell(
            pastOrder: PastOrderData(
                status: OrderStatus(rawValue: 2)!,
                driverName: "Mohammed",
                price: 100,
                time: Date(),
                fromPlace: "Rehab school",
                toPlace: "Saleh Road",
                rating: 4))
            .previewLayout(.fixed(width: 600, height: 210))
    }
}

struct PastOrderData : Identifiable {
    var id = UUID()
    
    var status : OrderStatus
    
    var driverName : String
    
    var price : Int
    
    
    var time : Date
    
    var fromPlace : String
    
    var toPlace : String
    
    var rating : Int
}

enum OrderStatus : Int {
    case cash = 0
    case credit = 1
    case cancelled = 2
    
    func desc() -> String {
        switch self {
        case .cash:
            return "Cash"
        case .credit:
            return "Credit"
        case .cancelled:
            return "Cancelled"
        }
    }
    
}


struct PastOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        PastOrdersView()
    }
}
