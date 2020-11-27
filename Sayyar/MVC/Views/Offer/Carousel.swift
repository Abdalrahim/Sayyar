//
//  Carousel.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 25/06/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct Carousel : UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        
        return Carousel.Coordinator(parent1: self)
    }
    
    var width : CGFloat
    @Binding var page : Int
    var height : CGFloat
    @State var count : Int
    
    func makeUIView(context: Context) -> UIScrollView{
        
        // ScrollView Content Size...
        
        let total = width * CGFloat(count)
        let view = UIScrollView()
        view.isPagingEnabled = true
        //1.0  For Disabling Vertical Scroll....
        view.contentSize = CGSize(width: total, height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        view.delegate = context.coordinator
        
        // Now Going to  embed swiftUI View Into UIView...
        
        let view1 = UIHostingController(rootView: Listing(page: self.$page))
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {}
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        var parent : Carousel
        
        init(parent1: Carousel) {
            
        
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            // Using This Function For Getting Currnet Page
            // Follow Me...
            
            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
            
            self.parent.page = page
        }
    }
}


struct PageControl : UIViewRepresentable {
    
    @Binding var page : Int
    @State var count : Int
    
    func makeUIView(context: Context) -> UIPageControl {
        
        let view = UIPageControl()
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        view.numberOfPages = count
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        
        // Updating Page Indicator When Ever Page Changes....
        
        DispatchQueue.main.async {
            
            uiView.currentPage = self.page
        }
    }
}
