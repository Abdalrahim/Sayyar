//
//  ReverseScrollView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 04/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Firebase

struct ReverseScrollView<Content>: View where Content: View {
    @State private var contentHeight: CGFloat = CGFloat.zero
    @State private var scrollOffset: CGFloat = CGFloat.zero
    @State private var currentOffset: CGFloat = CGFloat.zero
    
    var content: () -> Content
    
    // Calculate content offset
    func offset(outerheight: CGFloat, innerheight: CGFloat) -> CGFloat {
//        print("outerheight: \(outerheight) innerheight: \(innerheight)")
        
        let totalOffset = currentOffset + scrollOffset
        return -((innerheight/2 - outerheight/2) - totalOffset)
    }
    
    var body: some View {
        GeometryReader { outerGeometry in
            // Render the content
            //  ... and set its sizing inside the parent
            self.content()
            .modifier(ViewHeightKey())
            .onPreferenceChange(ViewHeightKey.self) { self.contentHeight = $0 }
            .frame(height: outerGeometry.size.height)
            .offset(y: self.offset(outerheight: outerGeometry.size.height, innerheight: self.contentHeight))
            .clipped()
            .animation(.easeInOut)
            .gesture(
                 DragGesture()
                    .onChanged({ self.onDragChanged($0) })
                    .onEnded({ self.onDragEnded($0, outerHeight: outerGeometry.size.height)}))
        }
    }
    
    func onDragChanged(_ value: DragGesture.Value) {
        // Update rendered offset
//        print("Start: \(value.startLocation.y)")
//        print("Start: \(value.location.y)")
        self.scrollOffset = (value.location.y - value.startLocation.y)
//        print("Scrolloffset: \(self.scrollOffset)")
    }
    
    func onDragEnded(_ value: DragGesture.Value, outerHeight: CGFloat) {
        // Update view to target position based on drag position
        let scrollOffset = value.location.y - value.startLocation.y
//        print("Ended currentOffset=\(self.currentOffset) scrollOffset=\(scrollOffset)")
        
        let topLimit = self.contentHeight - outerHeight
//        print("toplimit: \(topLimit)")
        
        // Negative topLimit => Content is smaller than screen size. We reset the scroll position on drag end:
        if topLimit < 0 {
             self.currentOffset = 0
        } else {
            // We cannot pass bottom limit (negative scroll)
            if self.currentOffset + scrollOffset < 0 {
                self.currentOffset = 0
            } else if self.currentOffset + scrollOffset > topLimit {
                self.currentOffset = topLimit
            } else {
                self.currentOffset += scrollOffset
            }
        }
//        print("new currentOffset=\(self.currentOffset)")
        self.scrollOffset = 0
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}

struct ReverseScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ReverseScrollView {
            VStack {
                ForEach(demoConversation) { message in
                    MessageView(text: message)
                }
            }
        }
        .previewLayout(.sizeThatFits)
    }
}

let demoConversation: [TextMessage] = {
    var conversation = [TextMessage(doc: demoTextDoc)]
    for index in 0..<40 {
        let doc : [String: Any] = [
            "text" :  "message \(index)",
            "time" : Timestamp(date: Date()),
            "senderId" : "Me"
        ]
        var message = TextMessage(doc: doc)
        conversation.append(message)
    }
    return conversation
}()
