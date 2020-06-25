//
//  SupportView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 19/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct SupportView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("general.support")
                .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                .font(.custom("Cairo-Regular", size: 16))
            VStack(spacing: 20) {
                NavigationLink(destination: ReportMissingView()) {
                    SupportCell(title: "forgot".localized, icon: Image("letter"))
                }
                .padding()
                .frame(height: 50)
                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)))
                .cornerRadius(5)
                
                NavigationLink(destination:
                    
                    ZStack {
                        Text("What separates Sayyar is how the offer comes from the partner.")
                            .font(.custom("Cairo-Regular", size: 18))
                            .padding()
                            .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)))
                            .navigationBarTitle("Pricing")
                    }
                    
                ) {
                    SupportCell(title: "pricing".localized, icon: Image("document"))
                }
                .padding()
                .frame(height: 50)
                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)))
                .cornerRadius(5)
                
                NavigationLink(destination: Text("")) {
                    SupportCell(title: "cancel.fees".localized, icon: Image("document"))
                }
                .padding()
                .frame(height: 50)
                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)))
                .cornerRadius(5)
                
            }
            
            Text("follow")
                .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                .font(.custom("Cairo-Regular", size: 16))
            
            VStack {
                NavigationLink(destination: ReportListView()) {
                    SupportCell(title: "reports".localized, icon: Image("document"))
                }
                .padding()
                .frame(height: 50)
                .background(Color(#colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)))
                .cornerRadius(5)
            }
            Spacer()
        }
        .padding()
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}

struct SupportCell: View {
    @State var title : String
    @State var icon : Image
    
    var body: some View {
        HStack {
            icon.renderingMode(.original)
            
            Text(title)
                .foregroundColor(.black)
                .font(.custom("Cairo-SemiBold", size: 17))
                .padding(.horizontal)
            Spacer()
            Image(systemName: L102Language.isRTL ? "Chevron.left" : "chevron.right").foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
        }
    }
}
