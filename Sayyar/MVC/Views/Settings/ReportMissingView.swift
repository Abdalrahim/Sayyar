//
//  ReportForgotView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 07/05/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct ReportMissingView: View {
    
    var settings = DataToTransfer()
    
    @State var selectedDate = Date()
    
    @State var reportTitle : String = ""
    
    @State var reportDetail : String = ""
    
    @State var tripTitle : String = ""
    
    @State var showHistory = false
    
    init() {
        UITableView.appearance().separatorColor = UIColor.clear
        UITableView.appearance().separatorInset = .zero
    }
    
    var body: some View {
        return Form {
//            VStack(alignment: .leading, spacing: 10)    {
            
            
            Text("support.title")
                .font(.custom("Cairo-Regular", size: 23))
            
            Text("support.subtitle")
                .font(.custom("Cairo-Regular", size: 15))
            
            Text("date.lostobject")
                .font(.custom("Cairo-SemiBold", size: 18))
                .frame(width: 200)
            
            DatePicker(selection: self.$selectedDate ,displayedComponents: .date) {
                HStack(spacing: 25) {
                    PurpleSquare(text: .constant("\(selectedDate.day)"), title: "Day")
                    PurpleSquare(text: .constant(selectedDate.monthAsString), title: "Month")
                }
            }
            
            
            Text("info.lostobject")
               .font(.custom("Cairo-SemiBold", size: 18))

            customTextField(placeholder: "Report Title", placename: $reportTitle, fieldReq: .constant(false)) {
            }
            
            TextView(text: $reportDetail).frame(height: 100)
            
            PurpleSquare(text: $tripTitle, title: "trip")
                .onTapGesture {
                    self.showHistory.toggle()
            }
             
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
        }
    .navigationBarTitle("support")
            
        .sheet(isPresented: self.$showHistory, content: {
            PastOrderSelect(presentPastOrders: self.$showHistory, title: self.$tripTitle).environmentObject(self.settings)
        })
            .onAppear {
                self.tripTitle = self.settings.orderId ?? "Select Trip"
        }
    }
}

struct PastOrderSelect: View {
    
    @EnvironmentObject var settings: DataToTransfer
    
    @Binding var presentPastOrders : Bool
    @Binding var title : String
    
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
                PastOrderCell(pastOrder: order).onTapGesture {
                    self.settings.orderId = order.driverName
                    self.title = order.driverName
                    self.presentPastOrders = false
                }
                
            }.background(Color(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)))
        }
        .navigationBarTitle("past trips")
    }
}

struct PurpleSquare : View {
    
    @Binding var text : String
    
    @State var title : String
    
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
            
            Text(title)
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
        ReportMissingView()
    }
}
