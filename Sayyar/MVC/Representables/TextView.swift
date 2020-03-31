//
//  TextView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import SZTextView

struct TextView: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> SZTextView {

        let myTextView = SZTextView()
        myTextView.delegate = context.coordinator
        myTextView.placeholder = "rate.me".localized
        myTextView.font = UIFont(name: "Cairo-SemiBold", size: 12)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.layer.borderWidth = 1
        myTextView.layer.borderColor = UIColor.lightGray.cgColor
        myTextView.layer.cornerRadius = 10
        return myTextView
    }

    func updateUIView(_ uiView: SZTextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView
        
        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.layer.borderColor = UIColor.purple.cgColor
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            textView.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}
