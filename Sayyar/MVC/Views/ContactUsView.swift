//
//  ContactUsView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 29/06/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import UIKit
 
struct ContactUsView: View {
    
     @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedContact : ReasonData? {
        didSet {
            self.reason = (L102Language.isRTL ? selectedContact?.name_ar : selectedContact?.name_en) ?? ""
        }
    }
    
    @State var reason : String = "contact.reason".localized
    
    @State var description : String = ""
    
    @State var title : String = ""
    
    @State var tripTitle : String = ""
    
    @State var showHistory = false
    
    @State var showOptions = false
    
    @State var alertTitle : String = ""
    
    @State var alertMessage : String = ""
    
    @State var showAlert : Bool = false
    
    @State var options : [ReasonData] = []
    
    var settings = DataToTransfer()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("send.order")
                .font(.custom("Cairo-SemiBold", size: 18))
                .foregroundColor(gray)
            
            VStack(alignment: .leading, spacing: -11) {
                PurpleSquare(text: self.$reason , title: "contact.reason".localized)
                    .font(.custom("Cairo-Regular", size: 16))
                    .foregroundColor(selectedContact == nil ? gray : purple)
                    .onTapGesture {
                        withAnimation {
                            self.showOptions.toggle()
                        }
                }
                if showOptions {
                    withAnimation {
                        HStack {
                            List() {
                                
                                ForEach(0..<options.count) { index in
                                    Text(L102Language.isRTL ? "\(self.options[index].name_ar ?? "")" : "\(self.options[index].name_en ?? "")")
                                        .onTapGesture {
                                            self.selectedContact = self.options[index]
                                            withAnimation {
                                                self.showOptions.toggle()
                                            }
                                    }
                                }
                            }.frame(height: CGFloat(50 * options.count))
                            .font(.custom("Cairo-Regular", size: 14))
                            
                            Spacer()
                        }
                        .padding(.horizontal, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2))
                                .foregroundColor(Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)))
                        )
                    }
                }
            }
            
            
            customTextField(placeholder: "report.title".localized, placename: $title, fieldReq: .constant(false)) {
                
            }
            .font(.custom("Cairo-Regular", size: 15))
            
            
            
            VStack(alignment: .leading, spacing: 0) {
                TextView(text: $description)
                    .frame(height: 150)
                Text("provide.info")
                    .font(.custom("Cairo-Regular", size: 15))
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
            }
            
            if self.selectedContact?.id == 2 {
                PurpleSquare(text: $tripTitle, title: "trip".localized)
                    .onTapGesture {
                        self.showHistory.toggle()
                }.font(.custom("Cairo-Regular", size: 16))
                
            }
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    self.sendContact()
                }
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("send")
                        .font(.custom("Cairo-SemiBold", size: 20))
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
            }
            .frame(height: 20, alignment: .center)
            .padding()
            .background(Color(#colorLiteral(red: 0.3450980392, green: 0.2039215686, blue: 0.4470588235, alpha: 1)))
            .cornerRadius(10)
            
            
        }
        .padding()
        .padding(.top)
        .navigationBarTitle("contact.us")
        .sheet(isPresented: self.$showHistory, content: {
            PastOrderSelect(presentPastOrders: self.$showHistory, title: self.$tripTitle).environmentObject(self.settings)
        })
            .onAppear {
                self.tripTitle = self.settings.orderId
                self.getReasons()
        }
        .alert(isPresented: self.$showAlert, content: {
            Alert(title: Text("Sent"), message: Text(self.alertMessage),
                  dismissButton: .default(Text("Ok"), action: {
                    self.presentationMode.wrappedValue.dismiss()
            }))
        })
    }
    
    private func sendContact() {
        GeneralEndPoint.contactUs(reason: selectedContact?.id, subject: title, description: description)
            .request { (response) in
            switch response {
            case .success(let tokenRsp):
                self.alertTitle = "contact.sent".localized
                self.alertMessage = ""
                self.showAlert.toggle()
                break
            case .failure(let failtxt):
                print("Failed sendContact", failtxt)
                self.alertTitle = "Failed sendContact"
                self.alertMessage = failtxt ?? ""
                self.showAlert.toggle()
            }
        }
    }
    
    private func getReasons() {
        GeneralEndPoint.purpose
            .request { (response) in
            switch response {
            case .success(let resonsArray):
                guard let reasons = resonsArray as? [ReasonData] else { return }
                self.options = reasons
                break
            case .failure(let failtxt):
                print("Failed sendContact", failtxt)
            }
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

struct ContactOption : Identifiable {
    var id = UUID()
    var title : String
    var type : contactType
    
    enum contactType : Int {
        case tech = 0
        case money = 1
        case driver = 2
        case faq = 3
        func desc() -> String {
            switch self {
            case .tech:
                return "tech.issue"
            case .money:
                return "money.issue"
            case .driver:
                return "driver"
            case .faq:
                return "faq.q"
            }
        }
    }
}
