//
//  ReportDetailView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 27/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct ReportDetailView: View {
    
    @State var report : ReportData
    
    @State var sayyarMessage : String = " نأمل منك الحضور لإستلام الغرض من مكتب سيار في حي الصفا٩  خلال ٢٤ ساعة من لحظة إشعارك بحالة البلاغ"
    @State var showMessage : Bool = false
    
    var imageStatus : Image {
        switch report.status {
        case .closed :
            return Image("")
        case .step1 :
            return Image("step1")
        case .step2:
            return Image("step2")
        case .step3:
            return Image("step3")
            
        }
    }
    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(getDate(format: "d/M/Y", date: report.reportDate))
                    Spacer()
                    Text("# \(report.reportNum)")
                }
                .font(.custom("Cairo-SemiBold", size: 12))
                .foregroundColor(Color(#colorLiteral(red: 0.5137254902, green: 0.5333333333, blue: 0.5568627451, alpha: 1)))
                
                HStack(alignment : .top, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Title")
                        Text("Message")
                    }
                    .font(.custom("Cairo-Bold", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1)))
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text(report.title)
                        Text(report.message)
                    }
                    .font(.custom("Cairo-SemiBold", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1)))
                }
            }
            .padding()
            .background(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1))).cornerRadius(17)
            
            if showMessage {
                Text(sayyarMessage)
                .font(.custom("Cairo-SemiBold", size: 15))
                .padding()
                .background(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1))).cornerRadius(17)
            }
            
            HStack {
                imageStatus
                
                VStack(alignment: .leading, spacing: 25) {
                    Text("Step 1")
                        .foregroundColor(
                            (
                                report.status == .step1 ||
                                report.status == .step2 ||
                                report.status == .step3) ? purple : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1))
                    )
                    Text("Step 2")
                        .foregroundColor(
                                (
                                    report.status == .step2 ||
                                    report.status == .step3) ? purple : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1))
                        )
                    Text("Step 3")
                        .foregroundColor((report.status == .step3) ? purple : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)))
                }
                .font(.custom("Cairo-SemiBold", size: 17))
                
                Spacer()
            }
            
            
            Spacer()
        }.padding()
    }
}

struct ReportDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReportDetailView(report: .init(title: "I forgot my phone in the car", reportNum: 2123, type: "some", reportDate: Date(), status: ReportStatus(rawValue: 1)!, message: "Black Black Berry Bold with motion sensor and NASA grade titanium cover made from a dying star."))
    }
}
