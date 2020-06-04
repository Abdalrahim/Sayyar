//
//  ReportListView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 22/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct ReportListView: View {
    
    
    @State var reports : [ReportData] = [
        ReportData(title: "نسيت جوالي في السيارة", reportNum: 234, type: "sent", reportDate: Date(), status: ReportStatus(rawValue: 1)!, message: "جوال آيفون XR أبيض عليه كفر شفاف صورة الخلفية بحر "),
        ReportData(title: "Lost My Phone", reportNum: 234, type: "sent", reportDate: Date(), status: ReportStatus(rawValue: 0)!, message: "I lost my phone in the white corolla")
    ]
    
    
    var body: some View {
        List {
            ForEach(reports) { report in
                ZStack {
                    ReportCell(report: report)
                    NavigationLink(destination: ReportDetailView(report: report)) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
    init() {
        UITableView.appearance().separatorColor = UIColor.clear
        UITableView.appearance().tableFooterView = UIView()
        
    }
}

struct ReportListView_Previews: PreviewProvider {
    static var previews: some View {
        ReportListView()
    }
}


struct ReportCell : View {
    
    @State var report : ReportData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("report.title")
                    .font(.custom("Cairo-Bold", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1)))
                Text(report.title)
                    .font(.custom("Cairo-SemiBold", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5333333333, blue: 0.5568627451, alpha: 1)))
            }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("report.num")
                    Text("report.date")
                }
                .font(.custom("Cairo-Bold", size: 15))
                .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1)))
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(report.reportNum)")
                    Text(getDate(format: "d/M/Y", date: report.reportDate))
                }
                .font(.custom("Cairo-SemiBold", size: 15))
                .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5333333333, blue: 0.5568627451, alpha: 1)))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("report.type")
                    Text("report.stat")
                }
                .font(.custom("Cairo-Bold", size: 15))
                .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1)))
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(report.type)
                    Text(report.status.desc())
                        .foregroundColor((report.status.rawValue == 1) ?  Color(#colorLiteral(red: 0.1294117647, green: 0.4862745098, blue: 0.3490196078, alpha: 1)) : Color(#colorLiteral(red: 0.5137254902, green: 0.5333333333, blue: 0.5568627451, alpha: 1)))
                }
                .font(.custom("Cairo-SemiBold", size: 15))
                .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5333333333, blue: 0.5568627451, alpha: 1)))
            }.navigationBarTitle("Reports")
            
        }
            
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .lineLimit(1)
            
//        .overlay(
//            RoundedRectangle(cornerRadius: 16)
//                .stroke(Color.black.opacity(0.1), lineWidth: 1)
//        )
            .shadow(radius: (report.status.rawValue == 0) ? 3 : 1)
    }
}


struct ReportCell_Previews: PreviewProvider {
    static var previews: some View {
        ReportCell(report:
            ReportData(title: "Lost My Phone", reportNum: 234, type: "sent", reportDate: Date(), status: ReportStatus(rawValue: 0)!, message: "")
            ).padding()
            .previewLayout(.sizeThatFits)
    }
}
