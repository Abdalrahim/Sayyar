//
//  SafariView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 28/06/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let sf = SFSafariViewController(url: url)
//        sf.preferredBarTintColor = .red
        return sf
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
