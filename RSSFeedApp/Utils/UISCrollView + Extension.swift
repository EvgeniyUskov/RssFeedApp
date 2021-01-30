//
//  UISCrollView + Extension.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 27.01.2021.
//

import UIKit

extension UIScrollView {
    static public func makeUIScrollView(frame: CGRect) -> UIScrollView {
        let scrollView = UIScrollView(frame: frame)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.contentSize = CGSize(width: frame.width, height: 2000)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: frame.size.width, height: scrollView.contentSize.height)
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }
}
