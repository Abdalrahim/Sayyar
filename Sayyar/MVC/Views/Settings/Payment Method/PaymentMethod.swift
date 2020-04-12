//
//  PaymentMethod.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 02/04/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct PaymentMethod: View {
    
    @State var methods : [Method] = [
        Method(type: .cash),
        Method(type: .visa)
    ]
    
    @State var showNewCupon : Bool = false
    
    init() {
        UITableView.appearance().separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 20)
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Image("payment")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding(.vertical)
                    Spacer()
                }
                .frame(height: geometry.size.height/3)
                .background(Color(#colorLiteral(red: 0.9606971145, green: 0.9608383775, blue: 0.9606793523, alpha: 1)))
                
                VStack(alignment: .leading, spacing: 0) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(purple)
                        .frame(width: 30, height: 30)
                        .background(
                            Circle().foregroundColor(Color(#colorLiteral(red: 0.9293273091, green: 0.9294641614, blue: 0.9293100238, alpha: 1)))
                    ).padding(.bottom)
                    
                    List(self.methods) { method in
                        MethodView(method: method)
                    }
                    
                    Text("Offers to use")
                        .font(.custom("Cairo-SemiBold", size: 18))
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            discountCard()
                                .onTapGesture {
                                    self.showNewCupon.toggle()
                            }
                        }
                    }
                }
                .padding(.top, -15)
                .padding(.horizontal)
                .padding(.bottom)
                
                Spacer()
                
                
            }
            .alert(isPresented: self.$showNewCupon) {
                Alert(title: Text("sa"))
            }
            .navigationBarTitle("payment.method")
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MethodView : View {
    @State var isSelected : Bool = false
    @State var method :Method
    
    var image: Image {
        switch method.type {
            
        case .cash :
            return Image("cash-pay")
            
            
        case .visa :
            return Image("visa")
        }
    }
    
    var name : String {
        switch method.type {
            
        case .cash :
            return "Cash"
            
            
        case .visa :
            return "*** 1234"
        }
    }
    
    var body: some View {
        HStack {
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(purple)
                .frame(width: 18, height: 18)
                .overlay(
                    Circle().foregroundColor(isSelected ? purple : .clear).frame(width: 10, height: 10)
            )
            
            image
                .resizable()
                .frame(width: 35, height: 25)
                .padding(.horizontal)
            
            Text(name)
                .font(.custom("Cairo-Regular", size: 18))
        }.onTapGesture {
            self.isSelected.toggle()
        }
    }
}
struct MethodView_Previews: PreviewProvider {
    static var previews: some View {
        MethodView(method: Method(type: .cash)).previewLayout(.fixed(width: 200, height: 50))
    }
}

struct Method : Identifiable {
    var id = UUID()
    
    var type : paymentType
    
    enum paymentType : Int {
        case cash = 0
        case visa = 1
    }
    
}

struct PaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethod()
    }
}


struct discountCard: View {
    
    var line: some View {
        VStack { Divider().background(purple) }.padding(.horizontal)
    }
    
    var body: some View {
        VStack {
            Text("New Offer")
                .font(.custom("Cairo-SemiBold", size: 16))
            Text("+ Offer")
                .font(.custom("Cairo-Regular", size: 14))
        }
        .frame(width: 120, height: 80)
        .background(
            
            Rectangle()
                .foregroundColor(Color(#colorLiteral(red: 0.9293273091, green: 0.9294641614, blue: 0.9293100238, alpha: 1)))
                .overlay(
                    HStack {
                        
                        
                        Line(height: 80)
                            .stroke(
                                purple,
                                style:
                                StrokeStyle(
                                    lineWidth: 1,
                                    lineCap: .butt,
                                    dash: [4]
                                )
                        ).frame(width: 1)
                            .foregroundColor(purple)
                            .padding(.leading)
                        
                        Spacer()
                        
                        
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(.trailing, -11)
                    }.frame(height: 80)
            )
        )
    }
}

struct Line: Shape {
    var height : CGFloat
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addLines([
                CGPoint(x: 0, y: 0),
                CGPoint(x:0, y: 0),
                CGPoint(x:0, y: height),
                CGPoint(x:0, y: height)
            ])
        }
    }
}

